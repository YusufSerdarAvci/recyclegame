// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Recycle Game';

  @override
  String get startGame => 'Start Game';

  @override
  String level(Object level) {
    return 'Level $level';
  }

  @override
  String score(Object score) {
    return 'Score: $score';
  }

  @override
  String correct(Object count) {
    return 'Correct: $count';
  }

  @override
  String wrong(Object count) {
    return 'Wrong: $count';
  }

  @override
  String get nextLevel => 'Next Level';

  @override
  String get gameOver => 'Game Over';

  @override
  String finalScore(Object score) {
    return 'Final Score: $score';
  }

  @override
  String get playAgain => 'Play Again';

  @override
  String get recycleBin => 'Recycle Bin';

  @override
  String get dragItems => 'Drag items to the correct bins';

  @override
  String get levelComplete => 'Level Complete!';

  @override
  String get congratulations => 'Congratulations!';

  @override
  String get timeRemaining => 'Time Remaining';

  @override
  String get correctAnswers => 'Correct Answers';

  @override
  String get wrongAnswers => 'Wrong Answers';

  @override
  String get progress => 'Progress';

  @override
  String itemsCompleted(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get paper => 'Paper';

  @override
  String get plastic => 'Plastic';

  @override
  String get glass => 'Glass';

  @override
  String get metal => 'Metal';

  @override
  String get organic => 'Organic';

  @override
  String get gameCompleted => 'Game Completed!';

  @override
  String get levelCompleted => 'Level Completed!';

  @override
  String starsEarned(Object stars) {
    return 'Stars Earned: $stars';
  }

  @override
  String get correctAnswersCount => 'Correct Answers';

  @override
  String get timeLeft => 'Time Left';

  @override
  String get successRate => 'Success Rate';

  @override
  String get seconds => 'seconds';

  @override
  String get homeMenu => 'Home Menu';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get nextLevelButton => 'Next Level';

  @override
  String get wellDone => 'Well Done!';

  @override
  String get greatJob => 'Great Job!';

  @override
  String get excellent => 'Excellent!';

  @override
  String get goodJob => 'Good Job!';

  @override
  String get keepTrying => 'Keep Trying!';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get music => 'Music';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get language => 'Language';
}
