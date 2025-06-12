import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recycle_game/data/game_levels.dart';
import 'package:recycle_game/models/recyclable_item.dart';
import 'package:recycle_game/screens/level_complete_screen.dart';
import 'package:recycle_game/services/audio_service.dart';
import 'package:recycle_game/widgets/draggable_item_widget.dart';
import 'package:recycle_game/widgets/educational_popup.dart';
import 'package:recycle_game/widgets/recycling_bin_widget.dart';

class GameScreen extends StatefulWidget {
  final int level;
  const GameScreen({required this.level, super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameLevel _currentLevel;
  late List<RecyclableItem> _itemsToRecycle;
  late int _timeLeft;
  Timer? _timer;

  int _score = 0;
  int _correctCount = 0;
  int _wrongCount = 0;

  @override
  void initState() {
    super.initState();
    _loadLevel(widget.level);
  }

  void _loadLevel(int levelIndex) {
    _currentLevel = gameLevels[levelIndex];
    _itemsToRecycle = List.from(_currentLevel.items);
    _timeLeft = _currentLevel.timeLimit;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        _levelFinished();
      }
    });
  }

  void _onItemDropped(RecyclableItem item, String binType) {
    setState(() {
      _itemsToRecycle.remove(item);
      if (item.type == binType) {
        _score += 10;
        _correctCount++;
        AudioService.playSfx('correct_answer.wav');
        if (item.educationalFactKey != null && mounted) {
          Future.delayed(const Duration(milliseconds: 500), () {
            showEducationalPopup(context, item.educationalFactKey ?? '');
          });
        }
      } else {
        _score -= 5;
        _wrongCount++;
        AudioService.playSfx('wrong_answer.wav');
      }

      if (_itemsToRecycle.isEmpty) {
        _timer?.cancel();
        _levelFinished();
      }
    });
  }

  void _levelFinished() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LevelCompleteScreen(
          score: _score,
          correctCount: _correctCount,
          wrongCount: _wrongCount,
          stars: _calculateStars(),
          currentLevel: widget.level,
          timeLeft: _timeLeft,
        ),
      ),
    );
  }

  int _calculateStars() {
    double successRate = _correctCount / _currentLevel.items.length;
    if (_timeLeft <= 0 && _itemsToRecycle.isNotEmpty) return 0; // Failed
    if (successRate == 1.0) return 3; // Perfect
    if (successRate >= 0.7) return 2;
    if (successRate >= 0.5) return 1;
    return 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final binTypes = ['paper', 'plastic', 'glass', 'metal', 'organic'];

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.level((widget.level + 1).toString()) ?? ''),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(child: Text('${localizations?.timeRemaining ?? ''}: $_timeLeft', style: const TextStyle(fontSize: 16))),
          )
        ],
      ),
      body: Column(
        children: [
          // Score and Info Header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(localizations?.score(_score.toString()) ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(localizations?.correct(_correctCount.toString()) ?? '', style: TextStyle(fontSize: 16, color: Colors.green[800])),
                Text(localizations?.wrong(_wrongCount.toString()) ?? '', style: TextStyle(fontSize: 16, color: Colors.red[800])),
              ],
            ),
          ),
          const Divider(),

          // Single Draggable Item Area
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.green[50],
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: _itemsToRecycle.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DraggableItemWidget(item: _itemsToRecycle.first),
                          const SizedBox(height: 24),
                          Text(
                            '${localizations?.progress ?? 'Progress'}: '
                            '${_currentLevel.items.length - _itemsToRecycle.length + 1}/${_currentLevel.items.length}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          const Divider(),

          // Bins Area (Row)
          SizedBox(
            height: 105,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: binTypes.map((binType) {
                return RecyclingBinWidget(
                  binType: binType,
                  onAccept: (item) {
                    _onItemDropped(item, binType);
                  },
                ).animate().fadeIn();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}