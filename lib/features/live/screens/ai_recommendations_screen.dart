import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_live_rooms.dart';
import '../widgets/live_room_preview.dart';
import 'live_room_screen.dart';

class AiRecommendationsScreen extends StatelessWidget {
  const AiRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // محاكاة توصيات
    final recommended = mockLiveRooms.where((r) => r.isLive).toList();
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7),
                itemCount: recommended.length,
                itemBuilder: (_, i) => LiveRoomPreview(
                  room: recommended[i],
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LiveRoomScreen(room: recommended[i]))),
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
      const Text('موصى بها', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
