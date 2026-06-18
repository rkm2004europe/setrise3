import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LivePollScreen extends StatefulWidget {
  const LivePollScreen({super.key});

  @override
  State<LivePollScreen> createState() => _LivePollScreenState();
}

class _LivePollScreenState extends State<LivePollScreen> {
  int _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              const Text('استفتاء مباشر', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 20),
              _option('خيار 1', 0),
              _option('خيار 2', 1),
              _option('خيار 3', 2),
              const SizedBox(height: 20),
              if (_selectedOption >= 0)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                    child: const Center(child: Text('تصويت', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _option(String text, int index) => GestureDetector(
        onTap: () => setState(() => _selectedOption = index),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _selectedOption == index ? LiveColors.accent.withOpacity(0.1) : LiveColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _selectedOption == index ? LiveColors.accent : LiveColors.border),
          ),
          child: Text(text, style: TextStyle(color: _selectedOption == index ? LiveColors.accent : LiveColors.text)),
        ),
      );

  Widget _buildTopBar(BuildContext context) => Row(
        children: [
          GestureDetector(
              onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
          const SizedBox(width: 12),
          const Text('استفتاء', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ],
      );
}
