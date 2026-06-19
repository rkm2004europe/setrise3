import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveEventsScreen extends StatelessWidget {
  const LiveEventsScreen({super.key});

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
                itemCount: 5,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [LiveColors.accent.withOpacity(0.1), LiveColors.surface],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: LiveColors.accent.withOpacity(0.3)),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('حدث ${i+1}', style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text('وصف الحدث المباشر...', style: const TextStyle(color: LiveColors.text2)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)),
                        child: const Text('انضم', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ]),
                ),
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
      const Text('الأحداث', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
