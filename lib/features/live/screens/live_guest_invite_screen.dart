import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/follow_controller.dart';

class LiveGuestInviteScreen extends StatelessWidget {
  final FollowController followCtrl;
  const LiveGuestInviteScreen({super.key, required this.followCtrl});

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
                itemCount: followCtrl.followedHosts.length,
                itemBuilder: (_, i) {
                  final host = followCtrl.followedHosts[i];
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: LiveColors.accent.withOpacity(0.1), child: Text(host['avatar'] as String)),
                    title: Text(host['name'] as String, style: const TextStyle(color: LiveColors.text)),
                    trailing: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)), child: const Text('دعوة', style: TextStyle(color: Colors.white, fontSize: 12))),
                    ),
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
      const Text('دعوة ضيوف', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
