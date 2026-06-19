import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const LiveBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: LiveColors.surface, border: Border(top: BorderSide(color: LiveColors.border))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _btn(0, Icons.home, 'الرئيسية'),
          _btn(1, Icons.explore, 'اكتشف'),
          _btn(2, Icons.card_giftcard, 'هدايا'),
          _btn(3, Icons.person, 'ملفي'),
        ],
      ),
    );
  }

  Widget _btn(int index, IconData icon, String label) => GestureDetector(
    onTap: () => onTap(index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: currentIndex == index ? LiveColors.accent : LiveColors.text2, size: 24),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(color: currentIndex == index ? LiveColors.accent : LiveColors.text2, fontSize: 10)),
    ]),
  );
}
