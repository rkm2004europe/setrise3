import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../setrize/screens/set_screen.dart';

class MediaPlayerScreen extends StatelessWidget {
  final String mediaUrl;
  final String description;
  const MediaPlayerScreen({super.key, required this.mediaUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    // يمكن فتح SetScreen مباشرة لعرض الفيديو كامل
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.play_circle_fill, size: 80, color: MapColors.accent),
                const SizedBox(height: 16),
                Text(description, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SetScreen()));
                  },
                  child: const Text('فتح في SetRize', style: TextStyle(color: MapColors.accent)),
                ),
              ]),
            ),
            Positioned(
              top: 16, left: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
