import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PipScreen extends StatelessWidget {
  const PipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.all(16),
            width: 120, height: 200,
            decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(12)),
            child: const Center(child: Text('PiP', style: TextStyle(color: LiveColors.text))),
          ),
        ),
      ),
    );
  }
}
