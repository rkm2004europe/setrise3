import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/date_question_model.dart';

class DateQuestionCard extends StatelessWidget {
  final DateQuestionModel question;
  const DateQuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: DateColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(question.question, style: const TextStyle(color: DateColors.text, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        ...question.options.map((o) => Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: DateColors.bg, borderRadius: BorderRadius.circular(12)),
          child: Text(o, style: const TextStyle(color: DateColors.text)),
        )),
      ]),
    );
  }
}
