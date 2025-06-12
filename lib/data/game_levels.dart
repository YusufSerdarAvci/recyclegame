import 'dart:math';
import 'package:recycle_game/models/recyclable_item.dart';
import 'package:recycle_game/data/waste_data.dart';

class GameLevel {
  final int timeLimit; // in seconds
  final List<RecyclableItem> items;

  GameLevel({required this.timeLimit, required this.items});
}

// Get all items from waste_data.dart
final List<RecyclableItem> allItems = [
  ...categorizedWasteItems['paper']!,
  ...categorizedWasteItems['plastic']!,
  ...categorizedWasteItems['glass']!,
  ...categorizedWasteItems['metal']!,
  ...categorizedWasteItems['organic']!,
];

final List<GameLevel> gameLevels = List.generate(10, (levelIndex) {
  final int itemCount = 10 + levelIndex * 5;
  final int timeLimit = 60 + levelIndex * 20;
  final random = Random(DateTime.now().millisecondsSinceEpoch + levelIndex);
  final items = List<RecyclableItem>.from(allItems)..shuffle(random);
  return GameLevel(
    timeLimit: timeLimit,
    items: items.take(itemCount).toList(),
  );
});