import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/game_facecam_widget.dart';
import '../widgets/unified_host_dashboard.dart';
import '../../setrize/screens/set_screen.dart';

class GameStreamScreen extends StatefulWidget {
  const GameStreamScreen({super.key});

  @override
  State<GameStreamScreen> createState() => _GameStreamScreenState();
}

class _GameStreamScreenState extends State<GameStreamScreen> {
  bool _showDashboard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // محاكاة شاشة اللعبة
          Container(
            color: LiveColors.surface,
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('🎮', style: TextStyle(fontSize: 80)),
                const SizedBox(height: 16),
                const Text('شاشة اللعبة', style: TextStyle(color: LiveColors.text2, fontSize: 18)),
              ]),
            ),
          ),
          // Facecam
          const GameFacecamWidget(),
          // شريط علوي
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(12)),
                    child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(12)),
                    child: const Text('230 مشاهد', style: TextStyle(color: LiveColors.text, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
          // لوحة التحكم
          if (_showDashboard)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: UnifiedHostDashboard(onEndStream: () => Navigator.pop(context)),
            ),
          // زر فتح اللوحة
          Positioned(
            bottom: 20, right: 20,
            child: GestureDetector(
              onTap: () => setState(() => _showDashboard = !_showDashboard),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), shape: BoxShape.circle),
                child: Icon(_showDashboard ? Icons.close : Icons.dashboard, color: LiveColors.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
GestureDetector(
  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SetScreen())),
  child: Container(...)
)
