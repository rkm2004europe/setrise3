Enterimport 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MultiAngleSelectorScreen extends StatefulWidget {
  const MultiAngleSelectorScreen({super.key});

  @override
  State<MultiAngleSelectorScreen> createState() => _MultiAngleSelectorScreenState();
}

class _MultiAngleSelectorScreenState extends State<MultiAngleSelectorScreen> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                children: List.generate(4, (i) => GestureDetector(
                  onTap: () => setState(() => _current = i),
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _current == i ? LiveColors.accent.withOpacity(0.3) : LiveColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _current == i ? LiveColors.accent : LiveColors.border),
                    ),
                    child: Center(child: Text(['أمامية', 'خلفية', 'ضيف 1', 'شاشة'][i], style: TextStyle(color: _current == i ? LiveColors.accent : LiveColors.text))),
                  ),
                )),
              ),
            ),
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
      const Text('زوايا الكاميرا', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
