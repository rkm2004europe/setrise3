Enterimport 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import 'call.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ChatColors.text)),
                  const Spacer(),
                  const Text('الملف الشخصي', style: TextStyle(color: ChatColors.text, fontSize: 18, fontWeight: FontWeight.w800)),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: ChatColors.surface), child: Center(child: Text(user.avatar, style: const TextStyle(fontSize: 40)))),
            const SizedBox(height: 12),
            Text(user.name, style: const TextStyle(color: ChatColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
            Text(user.username, style: const TextStyle(color: ChatColors.text2)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Btn(icon: Icons.message, label: 'رسالة', onTap: () => Navigator.pop(context)),
                const SizedBox(width: 16),
                _Btn(icon: Icons.call, label: 'مكالمة', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(user: user, isVideo: false)))),
                const SizedBox(width: 16),
                _Btn(icon: Icons.videocam, label: 'فيديو', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(user: user, isVideo: true)))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon; final String label; final VoidCallback onTap;
  const _Btn({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: ChatColors.accent, shape: BoxShape.circle), child: Icon(icon, color: Colors.white, size: 22)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: ChatColors.text2, fontSize: 11)),
        ],
      ),
    );
  }
}
