import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_questions.dart';

class DailyQuestionsScreen extends StatefulWidget {
  const DailyQuestionsScreen({super.key});

  @override
  State<DailyQuestionsScreen> createState() => _DailyQuestionsScreenState();
}

class _DailyQuestionsScreenState extends State<DailyQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: dailyQuestions.length,
                itemBuilder: (_, i) {
                  final q = dailyQuestions[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: DateColors.surface, borderRadius: BorderRadius.circular(16)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(q.question, style: const TextStyle(color: DateColors.text, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 10),
                      ...q.options.map((opt) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(color: DateColors.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: DateColors.border)),
                        child: Text(opt, style: const TextStyle(color: DateColors.text)),
                      )),
                      Text('${q.totalVotes} صوت', style: const TextStyle(color: DateColors.text2, fontSize: 11)),
                    ]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: DateColors.text)),
      const SizedBox(width: 12),
      const Text('الأسئلة اليومية', style: TextStyle(color: DateColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
