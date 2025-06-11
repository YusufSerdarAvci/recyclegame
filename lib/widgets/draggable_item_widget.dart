// lib/widgets/draggable_item_widget.dart
import 'package:flutter/material.dart';
import 'package:recycle_game/models/recyclable_item.dart';

class DraggableItemWidget extends StatelessWidget {
  final RecyclableItem item;

  const DraggableItemWidget({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable<RecyclableItem>(
      data: item,
      feedback: Image.asset(item.imagePath, height: 80, fit: BoxFit.contain),
      childWhenDragging: Opacity(
        opacity: 0.4,
        child: Image.asset(item.imagePath, height: 70, fit: BoxFit.contain),
      ),
      child: Image.asset(item.imagePath, height: 70, fit: BoxFit.contain),
    );
  }
}