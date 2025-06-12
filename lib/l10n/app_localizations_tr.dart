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

  @override
  String get guestProgressWarning =>
      'Misafir ilerlemesi kaydedilmez. Puanlarınızı kaydetmek için lütfen giriş yapın.';

  @override
  String get login => 'Giriş Yap';

  @override
  String get register => 'Kayıt Ol';

  @override
  String get guestLogin => 'Misafir Girişi';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get rememberMe => 'Beni Hatırla';

  @override
  String get dontHaveAccount => 'Hesabın yok mu? Kayıt Ol';

  @override
  String get alreadyHaveAccount => 'Zaten bir hesabın var mı? Giriş Yap';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get registerOrLogin => 'Kayıt Ol veya Giriş Yap';

  @override
  String get confirmPassword => 'Şifreyi Onayla';

  @override
  String get errorInvalidEmail => 'Lütfen geçerli bir e-posta adresi girin.';

  @override
  String get errorPasswordTooShort => 'Şifre en az 6 karakter olmalıdır.';

  @override
  String get errorConfirmPassword => 'Lütfen şifrenizi onaylayın.';

  @override
  String get errorPasswordsDoNotMatch => 'Şifreler eşleşmiyor.';

  @override
  String get errorEmailAlreadyInUse => 'Bu e-posta adresi zaten kullanımda.';

  @override
  String get errorInvalidCredentials => 'Geçersiz e-posta veya şifre.';

  @override
  String get errorWeakPassword => 'Şifre çok zayıf.';

  @override
  String get errorUserNotFound =>
      'Bu e-posta adresiyle kayıtlı kullanıcı bulunamadı.';

  @override
  String get errorTooManyRequests =>
      'Çok fazla deneme. Lütfen daha sonra tekrar deneyin.';

  @override
  String get errorNetworkRequestFailed =>
      'Ağ hatası. Lütfen bağlantınızı kontrol edin';

  @override
  String get educationalFact1 =>
      'Bir alüminyum kutuyu geri dönüştürmek, bir TV\'yi üç saat çalıştırmaya yetecek enerji tasarrufu sağlar.';

  @override
  String get educationalFact2 =>
      'Cam, saflığını veya kalitesini kaybetmeden sonsuz kez geri dönüştürülebilir.';

  @override
  String get educationalFact3 =>
      'Tek bir plastik şişeyi geri dönüştürmek, 60 watt\'lık bir ampulü altı saat boyunca çalıştırmaya yetecek enerji tasarrufu sağlar.';

  @override
  String get educationalFact4 =>
      'Kağıdı geri dönüştürmek, ham maddelerden üretmeye göre %60 daha az enerji kullanır.';

  @override
  String get educationalFact5 =>
      'Çöp sahalarındaki organik atıklar, güçlü bir sera gazı olan metan üretir. Kompostlama bu emisyonları azaltır.';

  @override
  String get educationalFact6 =>
      'Bir cam şişeyi geri dönüştürmekten elde edilen enerji, bir bilgisayarı 25 dakika çalıştırabilir.';

  @override
  String get educationalFact7 =>
      'Ortalama bir kişi her gün 2 kilogramdan fazla çöp üretir.';

  @override
  String get educationalFact8 =>
      'Çoğu plastik ürün, çöp sahasında en az 450 yılda ayrışır.';

  @override
  String get educationalFact9 =>
      'Bir ton kağıdı geri dönüştürmek, 17 olgun ağacı, 7.000 galon suyu ve 3 metreküp çöp sahası alanını kurtarır.';

  @override
  String get educationalFact10 =>
      'Çelik ve alüminyum sürekli olarak geri dönüştürülebilir, bu da onları oldukça sürdürülebilir malzemeler yapar.';

  @override
  String get educationalFact11 =>
      'Yemek artıkları ve bahçe atıkları, attığımız çöplerin %30\'undan fazlasını oluşturur.';

  @override
  String get educationalFact12 =>
      'Tüm plastikler aynı değildir. Doğru şekilde nasıl geri dönüştürüleceğini öğrenmek için geri dönüşüm sembolünü (üçgen içindeki numara) kontrol edin.';

  @override
  String get educationalFactsTitle => 'Eğitici Bilgiler';

  @override
  String get close => 'Kapat';

  @override
  String get anotherFact => 'Başka Bilgi';

  @override
  String get profileUpdated => 'Profil güncellendi!';

  @override
  String get displayName => 'Görünen Ad';

  @override
  String get nameCannotBeEmpty => 'İsim boş olamaz.';

  @override
  String get save => 'Kaydet';
}
