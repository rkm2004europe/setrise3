import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/fan_live_model.dart';
import '../data/mock_fan_lives.dart';

class FanLiveScreen extends StatelessWidget {
  const FanLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockFanLives.length,
                itemBuilder: (_, i) {
                  final fan = mockFanLives[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: LiveColors.accent.withOpacity(0.3))),
                    child: Row(children: [
                      const Icon(Icons.star, color: LiveColors.gold),
                      const SizedBox(width: 12),
                      Expanded(child: Text('بث خاص (${fan.currentViewers}/${fan.maxViewers})', style: const TextStyle(color: LiveColors.text))),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)),
                          child: const Text('انضم', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ]),
                  );
                },
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
      const Text('بث المعجبين', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
