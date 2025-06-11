import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle_game/services/settings_service.dart';
import 'package:recycle_game/data/game_levels.dart';
import 'package:recycle_game/screens/game_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Level'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: gameLevels.length,
          itemBuilder: (context, index) {
            final isUnlocked = settings.isLevelUnlocked(index);
            final stars = settings.levelStars[index] ?? 0;
            return Stack(
              children: [
                GestureDetector(
                  onTap: isUnlocked
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameScreen(level: index),
                            ),
                          );
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isUnlocked ? Colors.green[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isUnlocked ? Colors.green : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Level ${index + 1}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isUnlocked ? Colors.green[900] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (starIdx) => Icon(
                            starIdx < stars ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 28,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isUnlocked)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Image.asset(
                      'assets/images/default/lock.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
} 