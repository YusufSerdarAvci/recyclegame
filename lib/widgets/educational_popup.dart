// lib/widgets/educational_popup.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void showEducationalPopup(BuildContext context, String fact) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: const Text('Did You Know?'),
        content: Text(fact),
        actions: <Widget>[
          TextButton(
            child: const Text('Cool!'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.8, 0.8));
    },
  );
}