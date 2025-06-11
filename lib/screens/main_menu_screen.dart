// lib/screens/main_menu_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recycle_game/screens/level_selection_screen.dart';
import 'package:recycle_game/screens/leaderboard_screen.dart';
import 'package:recycle_game/screens/profile_screen.dart';
import 'package:recycle_game/screens/settings_screen.dart';
import 'package:recycle_game/services/audio_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    super.initState();
    // Start music when the menu appears
    AudioService.playMusic();
  }

  void _onButtonPressed(Function action) {
    AudioService.playSfx('button_click.wav');
    action();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/default/recycle_logo.png', height: 150)
                .animate()
                .scale(delay: 300.ms, duration: 500.ms),
            const SizedBox(height: 20),
            Text(
                  AppLocalizations.of(context)?.appTitle ?? '',
                  textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(blurRadius: 10.0, color: Colors.black.withOpacity(0.5))
                ],
              ),
            ).animate().fade(duration: 500.ms).slideY(begin: -1),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => _onButtonPressed(() {
                Navigator.push(
                  context,
                      MaterialPageRoute(builder: (context) => const LevelSelectionScreen()),
                );
              }),
                  child: Text(AppLocalizations.of(context)?.startGame ?? ''),
            ).animate().fade(delay: 600.ms).slideX(begin: -1),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _onButtonPressed(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
                );
              }),
                  child: Text(AppLocalizations.of(context)?.leaderboard ?? ''),
            ).animate().fade(delay: 700.ms).slideX(begin: 1),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _onButtonPressed(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              }),
                  child: Text(AppLocalizations.of(context)?.profile ?? ''),
            ).animate().fade(delay: 800.ms).slideX(begin: -1),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _onButtonPressed(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              }),
                  child: Text(AppLocalizations.of(context)?.settings ?? ''),
            ).animate().fade(delay: 900.ms).slideX(begin: 1),
          ],
            ),
          ),
        ),
      ),
    );
  }
}