import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import 'call.dart';
import 'profile.dart';

class ContactCard extends StatelessWidget {
  final User user;
  const ContactCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: ChatColors.surface, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundColor: ChatColors.surface, child: Text(user.avatar, style: const TextStyle(fontSize: 28))),
          const SizedBox(height: 8),
          Text(user.name, style: const TextStyle(color: ChatColors.text, fontWeight: FontWeight.w700)),
          Text(user.username, style: const TextStyle(color: ChatColors.text2)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: ChatColors.accent, shape: BoxShape.circle), child: const Icon(Icons.message, color: Colors.white, size: 18))),
              const SizedBox(width: 12),
              GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(user: user, isVideo: false))), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: ChatColors.accent, shape: BoxShape.circle), child: const Icon(Icons.call, color: Colors.white, size: 18))),
              const SizedBox(width: 12),
              GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: user))), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: ChatColors.accent, shape: BoxShape.circle), child: const Icon(Icons.person, color: Colors.white, size: 18))),
            ],
          ),
        ],
      ),
    );
  }
}
