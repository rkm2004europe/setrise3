import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BeautyFilterSlider extends StatefulWidget {
  const BeautyFilterSlider({super.key});

  @override
  State<BeautyFilterSlider> createState() => _BeautyFilterSliderState();
}

class _BeautyFilterSliderState extends State<BeautyFilterSlider> {
  double _smooth = 0.5, _brightness = 0.5, _faceShape = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.9), borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('تجميل', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
        _slider('نعومة', _smooth, (v) => setState(() => _smooth = v)),
        _slider('إضاءة', _brightness, (v) => setState(() => _brightness = v)),
        _slider('تحديد الوجه', _faceShape, (v) => setState(() => _faceShape = v)),
      ]),
    );
  }

  Widget _slider(String label, double value, Function(double) onChanged) {
    return Row(children: [
      SizedBox(width: 80, child: Text(label, style: const TextStyle(color: LiveColors.text2, fontSize: 12))),
      Expanded(child: Slider(value: value, min: 0, max: 1, activeColor: LiveColors.accent, onChanged: onChanged)),
    ]);
  }
}
