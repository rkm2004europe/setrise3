import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DateVerificationScreen extends StatelessWidget {
  const DateVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(width: 100, height: 100, decoration: BoxDecoration(color: DateColors.accent.withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.verified_user, color: DateColors.accent, size: 48)),
                    const SizedBox(height: 20),
                    const Text('التحقق من الصور', style: TextStyle(color: DateColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text('خذ صورة سيلفي لتأكيد هويتك وزيادة فرص التطابق.', textAlign: TextAlign.center, style: TextStyle(color: DateColors.text2)),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {},
                      child: Container(width: 200, height: 52, decoration: BoxDecoration(color: DateColors.accent, borderRadius: BorderRadius.circular(16)), child: const Center(child: Text('التقط صورة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)))),
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
}

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: DateColors.text)),
      const SizedBox(width: 12),
      const Text('التحقق', style: TextStyle(color: DateColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
