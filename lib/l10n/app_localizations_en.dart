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

  @override
  String get guestProgressWarning =>
      'Guest progress is not saved. Please log in to save your scores.';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get guestLogin => 'Guest Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get rememberMe => 'Remember Me';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Register';

  @override
  String get alreadyHaveAccount => 'Already have an account? Login';

  @override
  String get logout => 'Logout';

  @override
  String get registerOrLogin => 'Register or Login';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get errorInvalidEmail => 'Please enter a valid email address.';

  @override
  String get errorPasswordTooShort => 'Password must be at least 6 characters.';

  @override
  String get errorConfirmPassword => 'Please confirm your password.';

  @override
  String get errorPasswordsDoNotMatch => 'Passwords do not match.';

  @override
  String get errorEmailAlreadyInUse => 'This email is already in use.';

  @override
  String get errorInvalidCredentials => 'Invalid email or password.';

  @override
  String get errorWeakPassword => 'The password is too weak.';

  @override
  String get errorUserNotFound => 'No user found with this email.';

  @override
  String get errorTooManyRequests =>
      'Too many attempts. Please try again later.';

  @override
  String get errorNetworkRequestFailed =>
      'Network error. Please check your connection';

  @override
  String get educationalFact1 =>
      'Recycling one aluminum can saves enough energy to run a TV for three hours.';

  @override
  String get educationalFact2 =>
      'Glass is infinitely recyclable without any loss in purity or quality.';

  @override
  String get educationalFact3 =>
      'A single recycled plastic bottle saves enough energy to power a 60-watt light bulb for six hours.';

  @override
  String get educationalFact4 =>
      'Recycling paper uses 60% less energy than making it from raw materials.';

  @override
  String get educationalFact5 =>
      'Organic waste in landfills generates methane, a potent greenhouse gas. Composting it reduces these emissions.';

  @override
  String get educationalFact6 =>
      'The energy saved from recycling one glass bottle can power a computer for 25 minutes.';

  @override
  String get educationalFact7 =>
      'On average, a person generates over 4 pounds (about 2 kg) of trash every day.';

  @override
  String get educationalFact8 =>
      'Most plastic items take at least 450 years to decompose in a landfill.';

  @override
  String get educationalFact9 =>
      'Recycling one ton of paper saves 17 mature trees, 7,000 gallons of water, and 3 cubic yards of landfill space.';

  @override
  String get educationalFact10 =>
      'Steel and aluminum can be recycled over and over again, making them highly sustainable materials.';

  @override
  String get educationalFact11 =>
      'Food scraps and yard waste together constitute more than 30% of what we throw away.';

  @override
  String get educationalFact12 =>
      'Not all plastics are the same. Check the recycling symbol (a number inside a triangle) to know how to recycle it correctly.';

  @override
  String get educationalFactsTitle => 'Educational Facts';

  @override
  String get close => 'Close';

  @override
  String get anotherFact => 'Another Fact';

  @override
  String get profileUpdated => 'Profile updated!';

  @override
  String get displayName => 'Display Name';

  @override
  String get nameCannotBeEmpty => 'Name cannot be empty.';

  @override
  String get save => 'Save';
}
