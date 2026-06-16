import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/schedule_model.dart';

class LiveScheduleCard extends StatelessWidget {
  final ScheduleModel schedule;
  const LiveScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: LiveColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(width: 48, height: 48, decoration: BoxDecoration(color: LiveColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.live_tv, color: LiveColors.accent)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(schedule.title, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w700)),
          Text('${schedule.scheduledTime.day}/${schedule.scheduledTime.month} - ${schedule.scheduledTime.hour}:${schedule.scheduledTime.minute}', style: const TextStyle(color: LiveColors.text2)),
        ])),
      ]),
    );
  }
}
