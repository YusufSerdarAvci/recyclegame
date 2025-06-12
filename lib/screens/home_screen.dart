import 'package:flutter/material.dart';
import '../models/level.dart';
import '../models/recyclable_item.dart';
import 'game_screen.dart';
import 'dart:math';
import '../data/waste_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onLanguageChange;
  final Locale locale;
  const HomeScreen({Key? key, required this.onLanguageChange, required this.locale}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> unlockedLevels = List.generate(10, (index) => index == 0);
  List<int> levelStars = List.generate(10, (index) => 0);

  @override
  void initState() {
    super.initState();
    _loadUnlockedLevels();
    _loadLevelStars();
    // Force landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Don't reset orientation to maintain landscape mode
    super.dispose();
  }

  Future<void> _loadUnlockedLevels() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < unlockedLevels.length; i++) {
        unlockedLevels[i] = prefs.getBool('level_${i + 1}_unlocked') ?? (i == 0);
      }
    });
  }

  Future<void> _loadLevelStars() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < levelStars.length; i++) {
        levelStars[i] = prefs.getInt('level_${i + 1}_stars') ?? 0;
      }
    });
  }

  Future<void> unlockLevel(int levelIndex) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      unlockedLevels[levelIndex] = true;
    });
    await prefs.setBool('level_${levelIndex + 1}_unlocked', true);
  }

  Future<void> updateLevelStars(int levelIndex, int stars) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      levelStars[levelIndex] = stars;
    });
    await prefs.setInt('level_${levelIndex + 1}_stars', stars);
  }

  void onLevelCompleted(int levelNumber, int stars) async {
    if (levelNumber < unlockedLevels.length) {
      await updateLevelStars(levelNumber - 1, stars);
      // Only unlock next level if current level has 2 or more stars
      if (stars >= 2 && levelNumber < unlockedLevels.length) {
        await unlockLevel(levelNumber);
      }
    }
  }

  List<Level> get levels {
    final random = Random();
    List<Level> levels = [];
    int levelCount = 10;
    List<String> categories = categorizedWasteItems.keys.toList();
    for (int i = 0; i < levelCount; i++) {
      int itemsPerLevel = 10 + i * 2;
      List<RecyclableItem> levelItems = [];
      for (String category in categories) {
        List<RecyclableItem> wastes = List.from(categorizedWasteItems[category]!);
        wastes.shuffle(random);
        levelItems.addAll(wastes.take(itemsPerLevel ~/ categories.length));
      }
      levelItems.shuffle(random);
      levels.add(Level(
        levelNumber: i + 1,
        wasteItems: levelItems,
        timeLimit: (itemsPerLevel * 6),
      ));
    }
    return levels;
  }

  @override
  Widget build(BuildContext context) {
    final lvls = levels;
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          TextButton(
            onPressed: widget.onLanguageChange,
            child: Text(widget.locale.languageCode == 'tr' ? 'ENG' : 'TR'),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          ),
        ],
      ),
      body: Row(
        children: [
          // Left side - Welcome message
          Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loc.startGame,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/default/recycle_logo.png',
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right side - Scrollable level buttons
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ...List.generate(lvls.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Stack(
                          children: [
                            ElevatedButton(
                              onPressed: unlockedLevels[i]
                                  ? () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GameScreen(level: i),
                                        ),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(loc.level(lvls[i].levelNumber)),
                                  if (levelStars[i] > 0)
                                    Image.asset(
                                      'assets/images/stars/${levelStars[i]}star.png',
                                      height: 30,
                                    )
                                  else
                                    const SizedBox(width: 30), // Placeholder to maintain consistent spacing
                                ],
                              ),
                            ),
                            if (!unlockedLevels[i])
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Image.asset(
                                  'assets/images/default/lock.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}