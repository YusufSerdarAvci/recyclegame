import 'package:flutter/material.dart';
import 'package:recycle_game/services/auth_service.dart';
import 'package:recycle_game/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recycle_game/services/audio_service.dart';
import 'dart:convert';


class SettingsService with ChangeNotifier {
  late SharedPreferences _prefs;
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _auth = AuthService();

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

    final user = await _auth.user.first; 
    if (user != null) {
      final progress = await _firestoreService.getUserProgress(user.uid);
      final starsFromDb = progress['levelStars'] as Map<String, dynamic>;
      _levelStars = starsFromDb.map((key, value) => MapEntry(int.parse(key), value as int));
    }

    AudioService.updateSettings(_musicVolume, _sfxVolume);
    notifyListeners();
  }
  
  void setMusicVolume(double value) {
    if (_auth.isGuest) return; 
    _musicVolume = value;
    _prefs.setDouble('musicVolume', value);
    AudioService.updateSettings(_musicVolume, _sfxVolume);
    notifyListeners();
  }

  void setSfxVolume(double value) {
    if (_auth.isGuest) return; 
    _sfxVolume = value;
    _prefs.setDouble('sfxVolume', value);
    AudioService.updateSettings(_musicVolume, _sfxVolume);
    notifyListeners();
  }
  
  void setLocale(Locale locale) {
    if (_auth.isGuest) return;
    _locale = locale;
    _prefs.setString('languageCode', locale.languageCode);
    notifyListeners();
  }

  Future<void> setLevelStars(int level, int stars) async {
    if (_auth.isGuest) return; 

    final user = await _auth.user.first;
    if (user == null) return;
    
    if ((_levelStars[level] ?? 0) < stars) {
      _levelStars[level] = stars;
      await _firestoreService.updateUserLevelStars(user.uid, _levelStars); // Firestore'a yaz
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