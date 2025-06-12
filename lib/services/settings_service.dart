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
    
    final user = await _auth.user.first;
    if (user != null && !_auth.isGuest) {
      final progress = await _firestoreService.getUserProgress(user.uid);
      if (progress != null) {
        _musicVolume = (progress['musicVolume'] ?? 1.0).toDouble();
        _sfxVolume = (progress['sfxVolume'] ?? 1.0).toDouble();
        String langCode = progress['languageCode'] ?? 'en';
        _locale = Locale(langCode);
        
        final starsFromDb = progress['levelStars'];
        if (starsFromDb != null && starsFromDb is Map) {
          _levelStars = Map<int, int>.from(
            starsFromDb.map((key, value) => MapEntry(
              int.parse(key.toString()),
              (value is num) ? value.toInt() : int.parse(value.toString())
            ))
          );
        }
      }
    } else {
      _musicVolume = _prefs.getDouble('musicVolume') ?? 1.0;
      _sfxVolume = _prefs.getDouble('sfxVolume') ?? 1.0;
      String langCode = _prefs.getString('languageCode') ?? 'en';
      _locale = Locale(langCode);
    }

    AudioService.updateSettings(_musicVolume, _sfxVolume);
    notifyListeners();
  }
  
  Future<void> setMusicVolume(double value) async {
    _musicVolume = value;
    final user = await _auth.user.first;
    
    if (user != null && !_auth.isGuest) {
      await _firestoreService.updateUserSettings(
        user.uid,
        {'musicVolume': value},
      );
    } else {
      await _prefs.setDouble('musicVolume', value);
    }
    
    AudioService.updateSettings(_musicVolume, _sfxVolume);
    notifyListeners();
  }

  Future<void> setSfxVolume(double value) async {
    _sfxVolume = value;
    final user = await _auth.user.first;
    
    if (user != null && !_auth.isGuest) {
      await _firestoreService.updateUserSettings(
        user.uid,
        {'sfxVolume': value},
      );
    } else {
      await _prefs.setDouble('sfxVolume', value);
    }
    
    AudioService.updateSettings(_musicVolume, _sfxVolume);
    notifyListeners();
  }
  
  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    final user = await _auth.user.first;
    
    if (user != null && !_auth.isGuest) {
      try {
        await _firestoreService.updateUserSettings(
          user.uid,
          {'languageCode': locale.languageCode},
        );
      } catch (e) {
        print("Dil ayarı güncellenirken hata: $e");
        // Hata durumunda varsayılan dile geri dön
        _locale = const Locale('en');
        notifyListeners();
        rethrow;
      }
    } else {
      await _prefs.setString('languageCode', locale.languageCode);
    }
    
    notifyListeners();
  }

  Future<void> setLevelStars(int level, int stars) async {
    if (_auth.isGuest) return;

    try {
      final user = await _auth.user.first;
      if (user == null) return;
      
      final currentStars = _levelStars[level] ?? 0;
      if (stars > currentStars) {
        _levelStars[level] = stars;
        
        await _firestoreService.updateUserLevelStars(user.uid, _levelStars);
        
        notifyListeners();
      }
    } catch (e) {
      print("Level yıldızları ayarlanırken hata: $e");
      rethrow;
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