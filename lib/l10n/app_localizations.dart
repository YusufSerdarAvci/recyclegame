import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();


  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  String get appTitle;

  String get startGame;

  String level(Object level);

  String score(Object score);

  String correct(Object count);

  String wrong(Object count);

  String get nextLevel;

  String get gameOver;
  
  String finalScore(Object score);

  String get playAgain;

  String get recycleBin;

  String get dragItems;

  String get levelComplete;

  String get congratulations;

  String get timeRemaining;

  String get correctAnswers;

  String get wrongAnswers;

  String get progress;

  String itemsCompleted(Object current, Object total);
  String get paper;
  String get plastic;

  String get glass;

  String get metal;

  String get organic;

  String get gameCompleted;

  String get levelCompleted;

  String starsEarned(Object stars);

  String get correctAnswersCount;

  String get timeLeft;

  String get successRate;

  String get seconds;

  String get homeMenu;

  String get tryAgain;

  String get nextLevelButton;

  String get wellDone;

  String get greatJob;

  String get excellent;

  String get goodJob;

  String get keepTrying;

  String get leaderboard;

  String get profile;

  String get settings;

  String get music;

  String get soundEffects;

  String get language;

  String get login;

  String get register;

  String get guestLogin;

  String get email;

  String get password;

  String get rememberMe;

  String get dontHaveAccount;

  String get alreadyHaveAccount;

  String get logout;

  String get guestProgressWarning;

  String get registerOrLogin;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
