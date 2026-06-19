import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/follow_controller.dart';
import '../widgets/live_user_card.dart';
import '../../user/screens/user_preview_sheet.dart';

class LiveFollowingScreen extends StatelessWidget {
  final FollowController followCtrl;
  const LiveFollowingScreen({super.key, required this.followCtrl});

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
                  return LiveUserCard(
                    userId: host['id'] as String,
                    userName: host['name'] as String,
                    avatar: host['avatar'] as String,
                    vipLevel: host['vip'] as String? ?? '',
                    level: host['level'] as int? ?? 1,
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
          const Text('المتابَعون', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ]),
      );
}
