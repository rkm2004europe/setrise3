import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GameFacecamWidget extends StatelessWidget {
  const GameFacecamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        width: 100,
        height: 140,
        decoration: BoxDecoration(
          color: LiveColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: LiveColors.accent, width: 2),
        ),
        child: const Center(child: Text('🎮', style: TextStyle(fontSize: 40))),
      ),
    );
  }
}
