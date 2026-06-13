import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DisappearingScreen extends StatefulWidget {
  const DisappearingScreen({super.key});

  @override
  State<DisappearingScreen> createState() => _DisappearingScreenState();
}

class _DisappearingScreenState extends State<DisappearingScreen> {
  String _selected = 'إيقاف';

  @override
  Widget build(BuildContext context) {
    final options = ['إيقاف', '24 ساعة', '7 أيام', '90 يومًا'];
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
                  const Text('الرسائل المؤقتة', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: options.map((o) => ListTile(
                  title: Text(o, style: const TextStyle(color: ChatColors.text)),
                  trailing: _selected == o ? const Icon(Icons.check, color: ChatColors.accent) : null,
                  onTap: () { setState(() => _selected = o); Navigator.pop(context); },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
