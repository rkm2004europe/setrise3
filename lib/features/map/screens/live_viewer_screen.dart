import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveViewerScreen extends StatelessWidget {
  final String streamTitle;
  final String hostName;
  const LiveViewerScreen({super.key, required this.streamTitle, required this.hostName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.live_tv, size: 80, color: Colors.red),
              const SizedBox(height: 16),
              Text(streamTitle, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text('المضيف: $hostName', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: MapColors.accent),
                onPressed: () {},
                child: const Text('انضم للمشاهدة'),
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
    );
  }
}
