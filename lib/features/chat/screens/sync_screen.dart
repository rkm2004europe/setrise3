import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../controllers/sync_controller.dart';

class SyncScreen extends StatelessWidget {
  final SyncController controller;
  const SyncScreen({super.key, required this.controller});

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
                  const SizedBox(width: 12),
                  const Text('المزامنة', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: controller.syncing
                    ? const CircularProgressIndicator(color: ChatColors.accent)
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: ChatColors.accent),
                        onPressed: controller.sync,
                        child: const Text('مزامنة الآن', style: TextStyle(color: Colors.white)),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
