import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DatePreferencesScreen extends StatefulWidget {
  const DatePreferencesScreen({super.key});

  @override
  State<DatePreferencesScreen> createState() => _DatePreferencesScreenState();
}

class _DatePreferencesScreenState extends State<DatePreferencesScreen> {
  double _minAge = 18, _maxAge = 45, _distance = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: DateColors.text)),
                  const SizedBox(width: 12),
                  const Text('التفضيلات', style: TextStyle(color: DateColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _Slider(label: 'العمر الأدنى: ${_minAge.toInt()}', value: _minAge, min: 18, max: 60, onChanged: (v) => setState(() => _minAge = v)),
                  _Slider(label: 'العمر الأقصى: ${_maxAge.toInt()}', value: _maxAge, min: 18, max: 60, onChanged: (v) => setState(() => _maxAge = v)),
                  _Slider(label: 'المسافة: ${_distance.toInt()} كم', value: _distance, min: 1, max: 100, onChanged: (v) => setState(() => _distance = v)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  final String label;
  final double value, min, max;
  final Function(double) onChanged;
  const _Slider({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: DateColors.text2)),
          Slider(value: value, min: min, max: max, activeColor: DateColors.accent, onChanged: onChanged),
        ],
      ),
    );
  }
}
