import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'edit_date_profile_screen.dart';
import 'date_verification_screen.dart';

class MyDateProfileScreen extends StatelessWidget {
  const MyDateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // صورة البروفايل
              Stack(
                children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(color: DateColors.surface, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24))),
                    child: const Center(child: Text('😊', style: TextStyle(fontSize: 150))),
                  ),
                  Positioned(top: 16, left: 16, child: GestureDetector(onTap: () => Navigator.pop(context), child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle), child: const Icon(Icons.arrow_back, color: Colors.white)))),
                  Positioned(bottom: 16, right: 16, child: GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditDateProfileScreen())), child: Container(width: 40, height: 40, decoration: BoxDecoration(color: DateColors.accent, shape: BoxShape.circle), child: const Icon(Icons.edit, color: Colors.white)))),
                ],
              ),
              // معلومات
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('أنت، 25', style: TextStyle(color: DateColors.text, fontSize: 24, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  const Text('مطور تطبيقات | أحب السفر والموسيقى', style: TextStyle(color: DateColors.text2)),
                  const SizedBox(height: 16),
                  Row(children: [
                    _Stat(label: 'مرات الظهور', value: '1.2K'),
                    const SizedBox(width: 24),
                    _Stat(label: 'الإعجابات', value: '89'),
                    const SizedBox(width: 24),
                    _Stat(label: 'التطابقات', value: '12'),
                  ]),
                  const SizedBox(height: 20),
                  // أزرار
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DateVerificationScreen())),
                    child: Container(width: double.infinity, height: 48, margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: DateColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: const Center(child: Text('التحقق من الحساب', style: TextStyle(color: DateColors.accent)))),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  const _Stat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(color: DateColors.text, fontWeight: FontWeight.w900, fontSize: 20)),
    Text(label, style: const TextStyle(color: DateColors.text2, fontSize: 12)),
  ]);
}
