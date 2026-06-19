import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LiveReportScreen extends StatefulWidget {
  const LiveReportScreen({super.key});

  @override
  State<LiveReportScreen> createState() => _LiveReportScreenState();
}

class _LiveReportScreenState extends State<LiveReportScreen> {
  String _reason = '';

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
              _reasonOption('محتوى غير لائق'),
              _reasonOption('تحرش'),
              _reasonOption('عنف'),
              _reasonOption('انتهاك حقوق'),
              const Spacer(),
              GestureDetector(
                onTap: () { Navigator.pop(context); },
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('إرسال البلاغ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reasonOption(String text) => GestureDetector(
    onTap: () => setState(() => _reason = text),
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _reason == text ? LiveColors.accent.withOpacity(0.1) : LiveColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _reason == text ? LiveColors.accent : LiveColors.border),
      ),
      child: Text(text, style: TextStyle(color: _reason == text ? LiveColors.accent : LiveColors.text)),
    ),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
    const Text('إبلاغ', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
