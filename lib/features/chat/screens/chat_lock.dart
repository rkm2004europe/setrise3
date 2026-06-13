import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ChatLockScreen extends StatefulWidget {
  const ChatLockScreen({super.key});

  @override
  State<ChatLockScreen> createState() => _ChatLockScreenState();
}

class _ChatLockScreenState extends State<ChatLockScreen> {
  final _code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, color: ChatColors.accent, size: 64),
                const SizedBox(height: 16),
                const Text('قفل الشات', style: TextStyle(color: ChatColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                const Text('أدخل رمز المرور', style: TextStyle(color: ChatColors.text2)),
                const SizedBox(height: 20),
                TextField(controller: _code, obscureText: true, textAlign: TextAlign.center, style: const TextStyle(color: ChatColors.text, fontSize: 24, letterSpacing: 12), maxLength: 4, keyboardType: TextInputType.number, decoration: const InputBorder.none),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
