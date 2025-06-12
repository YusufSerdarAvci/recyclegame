import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recycle_game/screens/level_selection_screen.dart';
import 'package:recycle_game/screens/profile_screen.dart';
import 'package:recycle_game/screens/settings_screen.dart';
import 'package:recycle_game/services/audio_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recycle_game/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:recycle_game/screens/auth_screen.dart';
import 'package:recycle_game/widgets/educational_fact_popup.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    super.initState();
    AudioService.playMusic();
    _checkGuestStatus();
  }

  Future<void> _checkGuestStatus() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.checkIfGuest();
  }

  @override
  void dispose() {
    AudioService.stopMusic();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void _onButtonPressed(Function action) {
    AudioService.playSfx('button_click.wav');
    action();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (authService.isGuest)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      localizations.guestProgressWarning,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold),
                    ),
                  ),
                Image.asset('assets/images/default/recycle_logo.png', height: 150)
                    .animate()
                    .scale(delay: 300.ms, duration: 500.ms),
                const SizedBox(height: 20),
                Text(
                  localizations.appTitle,
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
                Wrap(
                  spacing: 15.0,
                  runSpacing: 15.0,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildMenuButton(
                      context,
                      icon: Icons.play_arrow,
                      label: localizations.startGame,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LevelSelectionScreen()),
                        );
                      },
                    ),
                    if (!authService.isGuest) 
                      _buildMenuButton(
                        context,
                        icon: Icons.person,
                        label: localizations.profile,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileScreen()),
                          );
                        },
                      ),
                    _buildMenuButton(
                      context,
                      icon: Icons.settings,
                      label: localizations.settings,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsScreen()),
                        );
                      },
                    ),
                    _buildMenuButton(
                      context,
                      icon: Icons.lightbulb_outline,
                      label: localizations.educationalFactsTitle,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const EducationalFactPopup(),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                if (authService.isGuest)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    label: Text(localizations.registerOrLogin),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    onPressed: () {
                      _onButtonPressed(() async {
                        await authService.signOut();
                        if (mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const AuthScreen()),
                          );
                        }
                      });
                    },
                  ),
                const SizedBox(height: 10),
                if (!authService.isGuest)
                  TextButton.icon(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      localizations.logout,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await authService.signOut();
                      if(mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const AuthScreen())
                        );
                      }
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget _buildMenuButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
  return ElevatedButton.icon(
    icon: Icon(icon),
    label: Text(label),
    onPressed: () => _onButtonPressed(onPressed),
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(fontSize: 16),
    ),
  );
}
}