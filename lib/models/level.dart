import 'waste_item.dart';

class Level {
  final int levelNumber;
  final List<WasteItem> wasteItems;
  final int timeLimit; // Her atık için süre (saniye)
  int correctAnswers = 0;
  int totalItems = 0;

  Level({
    required this.levelNumber,
    required this.wasteItems,
    this.timeLimit = 10,
  });

  int get stars {
    if (totalItems == 0) return 0;
    double percentage = (correctAnswers / totalItems) * 100;
    if (percentage >= 100) return 3;
    if (percentage >= 75) return 2;
    if (percentage >= 50) return 1;
    return 0;
  }
} 