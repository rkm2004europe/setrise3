import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveChallengeDetailScreen extends StatefulWidget {
  const LiveChallengeDetailScreen({super.key});

  @override
  State<LiveChallengeDetailScreen> createState() => _LiveChallengeDetailScreenState();
}

class _LiveChallengeDetailScreenState extends State<LiveChallengeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              const Text('تحدي الأسبوع', style: TextStyle(color: LiveColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              const Text('أرسل أكبر عدد من الهدايا واربح 1000 🪙', style: TextStyle(color: LiveColors.text2)),
              const SizedBox(height: 20),
              LinearProgressIndicator(value: 0.4, color: LiveColors.accent),
              const SizedBox(height: 10),
              const Text('40 / 100 هدية', style: TextStyle(color: LiveColors.text2)),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('شارك الآن', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
    const Text('تحدي مباشر', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
