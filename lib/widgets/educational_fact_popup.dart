import 'package:flutter/material.dart';
import 'package:recycle_game/l10n/app_localizations.dart';
import 'dart:math';

class EducationalFactPopup extends StatefulWidget {
  const EducationalFactPopup({super.key});

  @override
  State<EducationalFactPopup> createState() => _EducationalFactPopupState();
}

class _EducationalFactPopupState extends State<EducationalFactPopup> {
  String? _currentFact;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_currentFact == null) {
      _showRandomFact();
    }
  }

  void _showRandomFact() {
    final localizations = AppLocalizations.of(context)!;
    final facts = [
      localizations.educationalFact1,
      localizations.educationalFact2,
      localizations.educationalFact3,
      localizations.educationalFact4,
      localizations.educationalFact5,
      localizations.educationalFact6,
      localizations.educationalFact7,
      localizations.educationalFact8,
      localizations.educationalFact9,
      localizations.educationalFact10,
      localizations.educationalFact11,
      localizations.educationalFact12,
    ];
    setState(() {
      _currentFact = facts[_random.nextInt(facts.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lightbulb_outline,
              size: 40,
              color: Colors.amber,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.educationalFactsTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _currentFact ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(localizations.close),
                ),
                TextButton(
                  onPressed: () {
                    _showRandomFact();
                  },
                  child: Text(localizations.anotherFact),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 