import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/ar_filter_model.dart';
import '../data/mock_ar_filters.dart';

class ArFilterStudioScreen extends StatefulWidget {
  const ArFilterStudioScreen({super.key});

  @override
  State<ArFilterStudioScreen> createState() => _ArFilterStudioScreenState();
}

class _ArFilterStudioScreenState extends State<ArFilterStudioScreen> {
  String? _selectedFilterId;
  double _intensity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(_selectedFilterId ?? 'بدون فلتر', style: const TextStyle(color: LiveColors.text, fontSize: 24)),
                  const SizedBox(height: 8),
                  Text('اختر فلترًا وجرب المعاينة', style: const TextStyle(color: LiveColors.text2)),
                ]),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mockArFilters.length,
                itemBuilder: (_, i) {
                  final filter = mockArFilters[i];
                  final isSelected = _selectedFilterId == filter.id;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilterId = filter.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 80, margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? LiveColors.accent.withOpacity(0.2) : LiveColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: isSelected ? Border.all(color: LiveColors.accent, width: 2) : null,
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(filter.thumbnailEmoji, style: const TextStyle(fontSize: 28)),
                        Text(filter.name, style: TextStyle(color: isSelected ? LiveColors.accent : LiveColors.text2, fontSize: 10)),
                      ]),
                    ),
                  );
                },
              ),
            ),
            if (_selectedFilterId != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  const Text('الشدة', style: TextStyle(color: LiveColors.text2)),
                  Expanded(child: Slider(value: _intensity, min: 0, max: 2, activeColor: LiveColors.accent, onChanged: (v) => setState(() => _intensity = v))),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('استوديو الفلاتر', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
