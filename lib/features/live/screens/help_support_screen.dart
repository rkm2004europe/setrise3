import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  ListTile(leading: Icon(Icons.question_answer, color: LiveColors.text), title: Text('الأسئلة الشائعة', style: TextStyle(color: LiveColors.text))),
                  ListTile(leading: Icon(Icons.support, color: LiveColors.text), title: Text('الدعم الفني', style: TextStyle(color: LiveColors.text))),
                  ListTile(leading: Icon(Icons.flag, color: LiveColors.text), title: Text('الإبلاغ عن مشكلة', style: TextStyle(color: LiveColors.text))),
                ],
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
      const Text('المساعدة', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
