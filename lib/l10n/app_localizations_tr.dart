// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Geri Dönüşüm Oyunu';

  @override
  String get startGame => 'Oyuna Başla';

  @override
  String level(Object level) {
    return 'Seviye $level';
  }

  @override
  String score(Object score) {
    return 'Puan: $score';
  }

  @override
  String correct(Object count) {
    return 'Doğru: $count';
  }

  @override
  String wrong(Object count) {
    return 'Yanlış: $count';
  }

  @override
  String get nextLevel => 'Sonraki Seviye';

  @override
  String get gameOver => 'Oyun Bitti';

  @override
  String finalScore(Object score) {
    return 'Toplam Puan: $score';
  }

  @override
  String get playAgain => 'Tekrar Oyna';

  @override
  String get recycleBin => 'Geri Dönüşüm Kutusu';

  @override
  String get dragItems => 'Öğeleri doğru kutulara sürükleyin';

  @override
  String get levelComplete => 'Seviye Tamamlandı!';

  @override
  String get congratulations => 'Tebrikler!';

  @override
  String get timeRemaining => 'Kalan Süre';

  @override
  String get correctAnswers => 'Doğru Cevaplar';

  @override
  String get wrongAnswers => 'Yanlış Cevaplar';

  @override
  String get progress => 'İlerleme';

  @override
  String itemsCompleted(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get paper => 'Kağıt';

  @override
  String get plastic => 'Plastik';

  @override
  String get glass => 'Cam';

  @override
  String get metal => 'Metal';

  @override
  String get organic => 'Organik';

  @override
  String get gameCompleted => 'Oyun Tamamlandı!';

  @override
  String get levelCompleted => 'Seviye Tamamlandı!';

  @override
  String starsEarned(Object stars) {
    return 'Kazandığınız Yıldız: $stars';
  }

  @override
  String get correctAnswersCount => 'Doğru Cevap';

  @override
  String get timeLeft => 'Kalan Süre';

  @override
  String get successRate => 'Başarı Oranı';

  @override
  String get seconds => 'saniye';

  @override
  String get homeMenu => 'Ana Menü';

  @override
  String get tryAgain => 'Tekrar Dene';

  @override
  String get nextLevelButton => 'Sonraki Seviye';

  @override
  String get wellDone => 'Aferin!';

  @override
  String get greatJob => 'Harika İş!';

  @override
  String get excellent => 'Mükemmel!';

  @override
  String get goodJob => 'İyi İş!';

  @override
  String get keepTrying => 'Devam Et!';

  @override
  String get leaderboard => 'Lider Tablosu';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Ayarlar';

  @override
  String get music => 'Müzik';

  @override
  String get soundEffects => 'Ses Efektleri';

  @override
  String get language => 'Dil';
}
