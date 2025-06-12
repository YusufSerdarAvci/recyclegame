import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recycle_game/services/audio_service.dart';
import 'package:recycle_game/services/settings_service.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _musicVolume = 1.0;
  double _sfxVolume = 1.0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = Provider.of<SettingsService>(context, listen: false);
    await settings.loadSettings();
    if (mounted) {
      setState(() {
        _musicVolume = settings.musicVolume;
        _sfxVolume = settings.sfxVolume;
        _loading = false;
      });
    }
  }

  Future<void> _updateSettings() async {
    final settings = Provider.of<SettingsService>(context, listen: false);
    await settings.setMusicVolume(_musicVolume);
    await settings.setSfxVolume(_sfxVolume);
    AudioService.updateSettings(_musicVolume, _sfxVolume);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final settings = Provider.of<SettingsService>(context);

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.settings ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations?.music ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Slider(
              value: _musicVolume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: (_musicVolume * 100).toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _musicVolume = value;
                  _updateSettings();
                });
              },
            ),
            const SizedBox(height: 16),
            Text(localizations?.soundEffects ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Slider(
              value: _sfxVolume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: (_sfxVolume * 100).toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _sfxVolume = value;
                  _updateSettings();
                });
              },
            ),
            const SizedBox(height: 24),
            Text(localizations?.language ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('English'),
                    value: 'en',
                    groupValue: settings.locale.languageCode,
                    onChanged: (value) {
                      if (value != null) {
                        settings.setLocale(Locale(value));
                      }
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Türkçe'),
                    value: 'tr',
                    groupValue: settings.locale.languageCode,
                    onChanged: (value) {
                      if (value != null) {
                        settings.setLocale(Locale(value));
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}