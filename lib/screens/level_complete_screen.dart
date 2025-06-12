// lib/screens/level_complete_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recycle_game/data/game_levels.dart';
import 'package:recycle_game/screens/game_screen.dart';
import 'package:recycle_game/screens/main_menu_screen.dart';
import 'package:recycle_game/services/audio_service.dart';
import 'package:recycle_game/services/auth_service.dart';
import 'package:recycle_game/services/firestore_service.dart';
import 'package:recycle_game/services/settings_service.dart';
import 'package:provider/provider.dart';

class LevelCompleteScreen extends StatefulWidget {
  final int score;
  final int correctCount;
  final int wrongCount;
  final int stars;
  final int currentLevel;
  final int timeLeft;

  const LevelCompleteScreen({
    super.key,
    required this.score,
    required this.correctCount,
    required this.wrongCount,
    required this.stars,
    required this.currentLevel,
    required this.timeLeft,
  });

  @override
  State<LevelCompleteScreen> createState() => _LevelCompleteScreenState();
}

class _LevelCompleteScreenState extends State<LevelCompleteScreen> {
  bool _isGameCompleted = false;

  @override
  void initState() {
    super.initState();
    _isGameCompleted = widget.currentLevel >= gameLevels.length - 1;
    // Save score to leaderboard
    _submitScore();
    // Save stars to settings
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settings = Provider.of<SettingsService>(context, listen: false);
      settings.setLevelStars(widget.currentLevel, widget.stars);
      if (widget.stars > 1) {
        AudioService.playSfx('level_completed.mp3');
      } else {
        AudioService.playSfx('level_failed.mp3');
      }
    });
  }

  Future<void> _submitScore() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    
    if (authService.isGuest) return;

    final user = await authService.user.first;
    if (user != null) {
      await firestoreService.submitScore(uid: user.uid, score: widget.score);
    }
  }

  void _onButtonPressed(Function action) {
    AudioService.playSfx('click.wav');
    action();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final successRate = widget.correctCount + widget.wrongCount == 0 ? 0 : (widget.correctCount / (widget.correctCount + widget.wrongCount) * 100).toStringAsFixed(0);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            margin: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.stars > 0
                      ? (_isGameCompleted
                          ? (localizations?.gameCompleted ?? '')
                          : (localizations?.levelCompleted ?? ''))
                      : (localizations?.gameOver ?? ''),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ).animate().fade(duration: 500.ms),
                const SizedBox(height: 20),
                // Animated Stars
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Animate(
                      effects: [
                        if (index < widget.stars)
                          ScaleEffect(
                            delay: (300 * (index + 1)).ms,
                            duration: 400.ms,
                            curve: Curves.elasticOut,
                          ),
                      ],
                      child: Icon(
                        index < widget.stars ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 60,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                _buildStatRow(localizations?.finalScore(widget.score.toString()) ?? '', '', isTitle: true),
                const Divider(),
                _buildStatRow(localizations?.correctAnswersCount ?? '', '${widget.correctCount}'),
                _buildStatRow(localizations?.timeLeft ?? '', '${widget.timeLeft} ${localizations?.seconds ?? ''}'),
                _buildStatRow(localizations?.successRate ?? '', '$successRate%'),
                const SizedBox(height: 30),
                if (widget.stars >= 2 && !_isGameCompleted)
                  ElevatedButton(
                    onPressed: () => _onButtonPressed(() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GameScreen(level: widget.currentLevel + 1)));
                    }),
                    child: Text(localizations?.nextLevelButton ?? ''),
                  ).animate().slideY(delay: 1500.ms),
                const SizedBox(height: 10),
                if (widget.stars < 2)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[700]),
                    onPressed: () => _onButtonPressed(() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GameScreen(level: widget.currentLevel)));
                    }),
                    child: Text(localizations?.tryAgain ?? ''),
                  ).animate().slideY(delay: 1500.ms),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => _onButtonPressed(() {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const MainMenuScreen()),
                          (Route<dynamic> route) => false,
                    );
                  }),
                  child: Text(localizations?.homeMenu ?? ''),
                ).animate().fade(delay: 1700.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String title, String value, {bool isTitle = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: isTitle ? 22 : 18, fontWeight: isTitle ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: isTitle ? 22 : 18, fontWeight: FontWeight.bold, color: Colors.green[700])),
        ],
      ),
    );
  }
}