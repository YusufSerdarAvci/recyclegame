// lib/services/settings_service.dart
// Manages loading and saving app settings.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recycle_game/services/audio_service.dart';
import 'dart:convert';

class SettingsService with ChangeNotifier {
  late SharedPreferences _prefs;

  double _musicVolume = 1.0;
  double _sfxVolume = 1.0;
  Locale _locale = const Locale('en');
  Map<int, int> _levelStars = {};

  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;
  Locale get locale => _locale;
  Map<int, int> get levelStars => _levelStars;

  SettingsService() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _musicVolume = _prefs.getDouble('musicVolume') ?? 1.0;
    _sfxVolume = _prefs.getDouble('sfxVolume') ?? 1.0;
    String langCode = _prefs.getString('languageCode') ?? 'en';
    _locale = Locale(langCode);
    // Level yıldızlarını yükle
    final starsString = _prefs.getString('levelStars') ?? '{}';
    _levelStars = Map<int, int>.from((starsString.isNotEmpty ? Map<String, dynamic>.from(_decodeJson(starsString)) : {}));
    _levelStars = _levelStars.map((k, v) => MapEntry(int.parse(k.toString()), v));
    AudioService.updateSettings(_musicVolume, _sfxVolume);
    notifyListeners();
  }

  void setMusicVolume(double value) {
    _musicVolume = value;
    _prefs.setDouble('musicVolume', value);
    AudioService.updateSettings(_musicVolume, _sfxVolume);
    notifyListeners();
  }

  void setSfxVolume(double value) {
    _sfxVolume = value;
    _prefs.setDouble('sfxVolume', value);
    AudioService.updateSettings(_musicVolume, _sfxVolume);
    notifyListeners();
  }
  
  void setLocale(Locale locale) {
    _locale = locale;
    _prefs.setString('languageCode', locale.languageCode);
    notifyListeners();
  }

  void setLevelStars(int level, int stars) {
    if ((_levelStars[level] ?? 0) < stars) {
      _levelStars[level] = stars;
      _prefs.setString('levelStars', _encodeJson(_levelStars));
      notifyListeners();
    }
  }

  bool isLevelUnlocked(int level) {
    if (level == 0) return true;
    return (_levelStars[level - 1] ?? 0) >= 2;
  }

  dynamic _decodeJson(String s) {
    try {
      return s.isNotEmpty ? (s.startsWith('{') ? jsonDecode(s) : {}) : {};
    } catch (_) {
      return {};
    }
  }

  String _encodeJson(Map<int, int> map) {
    return map.map((k, v) => MapEntry(k.toString(), v)).toString();
  }
}