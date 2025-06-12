import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioPlayer _musicPlayer = AudioPlayer();
  static final AudioPlayer _sfxPlayer = AudioPlayer();

  static double _musicVolume = 1.0;
  static double _sfxVolume = 1.0;
  static bool _isMusicPlaying = false;

  static void updateSettings(double musicVolume, double sfxVolume) {
    _musicVolume = musicVolume;
    _sfxVolume = sfxVolume;
    _musicPlayer.setVolume(_musicVolume);
    _sfxPlayer.setVolume(_sfxVolume);
  }

  static Future<void> playMusic() async {
    if (_musicVolume > 0 && !_isMusicPlaying) {
      _isMusicPlaying = true;
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.setVolume(_musicVolume);
      await _musicPlayer.play(AssetSource('audio/music/background.mp3'));
    }
  }

  static void playSfx(String soundName) {
    if (soundName.endsWith('.mp3')) {
      _musicPlayer.setReleaseMode(ReleaseMode.release);
      _musicPlayer.setVolume(_musicVolume);
      _musicPlayer.play(AssetSource('audio/music/$soundName'));
    } else if (_sfxVolume > 0) {
      _sfxPlayer.setVolume(_sfxVolume);
      _sfxPlayer.play(AssetSource('audio/sfx/$soundName'));
    }
  }

  static Future<void> playMusicAsync() async {
    if (_musicVolume == 0 || _musicPlayer.state == PlayerState.playing) return;
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(_musicVolume);
    await _musicPlayer.play(AssetSource('audio/music/background_music.mp3'));
  }

  static Future<void> stopMusic() async {
    _isMusicPlaying = false;
    await _musicPlayer.stop();
  }

  static void dispose() {
    _isMusicPlaying = false;
    _musicPlayer.dispose();
    _sfxPlayer.dispose();
  }
}