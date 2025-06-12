import 'package:flutter/material.dart';
import 'package:recycle_game/l10n/app_localizations.dart';
import 'package:recycle_game/models/recyclable_item.dart';

class RecyclingBinWidget extends StatelessWidget {
  final String binType;
  final Function(RecyclableItem) onAccept;

  const RecyclingBinWidget({
    required this.binType,
    required this.onAccept,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        double binHeight = constraints.maxHeight * 0.7; 
        return DragTarget<RecyclableItem>(
          builder: (context, candidateData, rejectedData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/bins/${binType}_bin.png', height: binHeight),
                const SizedBox(height: 4),
                Text(_localizedBinName(localizations, binType)),
              ],
            );
          },
          onWillAcceptWithDetails: (details) => true,
          onAcceptWithDetails: (details) {
            onAccept(details.data);
          },
        );
      },
    );
  }

  String _localizedBinName(AppLocalizations? localizations, String binType) {
    switch (binType) {
      case 'paper':
        return localizations?.paper ?? '';
      case 'plastic':
        return localizations?.plastic ?? '';
      case 'glass':
        return localizations?.glass ?? '';
      case 'metal':
        return localizations?.metal ?? '';
      case 'organic':
        return localizations?.organic ?? '';
      default:
        return binType;
    }
  }
}