import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StreamReminderScreen extends StatefulWidget {
  const StreamReminderScreen({super.key});

  @override
  State<StreamReminderScreen> createState() => _StreamReminderScreenState();
}

class _StreamReminderScreenState extends State<StreamReminderScreen> {
  bool _reminderSet = true;

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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  const Icon(Icons.alarm, size: 48, color: LiveColors.accent),
                  const SizedBox(height: 12),
                  const Text('تذكير قبل البث', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('سنذكرك قبل 10 دقائق من بدء البث', style: TextStyle(color: LiveColors.text2)),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('تفعيل التذكير', style: TextStyle(color: LiveColors.text)),
                    value: _reminderSet,
                    onChanged: (v) => setState(() => _reminderSet = v),
                    activeColor: LiveColors.accent,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(
        children: [
          GestureDetector(
              onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
          const SizedBox(width: 12),
          const Text('تذكير', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ],
      );
}
