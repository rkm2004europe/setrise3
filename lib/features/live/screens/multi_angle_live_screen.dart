import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MultiAngleLiveScreen extends StatefulWidget {
  const MultiAngleLiveScreen({super.key});

  @override
  State<MultiAngleLiveScreen> createState() => _MultiAngleLiveScreenState();
}

class _MultiAngleLiveScreenState extends State<MultiAngleLiveScreen> {
  String _angle = 'front';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: Text('زاوية $_angle', style: const TextStyle(color: LiveColors.text, fontSize: 24))),
            Positioned(
              bottom: 20, left: 20, right: 20,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                _angleBtn('front', 'أمامية'),
                _angleBtn('back', 'خلفية'),
                _angleBtn('guest1', 'ضيف'),
                _angleBtn('screen', 'شاشة'),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _angleBtn(String angle, String label) => GestureDetector(
    onTap: () => setState(() => _angle = angle),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: _angle == angle ? LiveColors.accent : LiveColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(color: _angle == angle ? Colors.white : LiveColors.text2)),
    ),
  );
}
