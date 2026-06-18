import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WatchPartyScreen extends StatelessWidget {
  const WatchPartyScreen({super.key});

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
                  const Icon(Icons.video_library, size: 64, color: LiveColors.accent),
                  const SizedBox(height: 16),
                  const Text('مشاهدة جماعية', style: TextStyle(color: LiveColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('شاهد الفيديوهات مع أصدقائك', style: TextStyle(color: LiveColors.text2)),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                      child: const Text('ابدأ حفلة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
            const SizedBox(width: 12),
            const Text('حفلة مشاهدة', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
