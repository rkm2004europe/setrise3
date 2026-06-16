import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PrivateRoomScreen extends StatelessWidget {
  const PrivateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.lock, size: 64, color: LiveColors.accent),
            const SizedBox(height: 16),
            const Text('غرفة خاصة', style: TextStyle(color: LiveColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('ادخل كلمة المرور', style: TextStyle(color: LiveColors.text2)),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextField(
                obscureText: true,
                style: const TextStyle(color: LiveColors.text),
                decoration: InputDecoration(
                  hintText: '****',
                  hintStyle: TextStyle(color: LiveColors.text2.withOpacity(0.5)),
                  filled: true, fillColor: LiveColors.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
