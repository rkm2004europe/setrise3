import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/event_model.dart';

class EventDetailScreen extends StatelessWidget {
  final EventModel event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              Text(event.title, style: const TextStyle(color: MapColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Text(event.description, style: const TextStyle(color: MapColors.text2)),
              const SizedBox(height: 20),
              _infoRow('المضيف', event.hostName),
              _infoRow('الحضور', '${event.attendeesCount}'),
              _infoRow('البداية', '${event.startTime.hour}:${event.startTime.minute}'),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: MapColors.blue, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('تأكيد الحضور', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(children: [
      Text('$label: ', style: const TextStyle(color: MapColors.text2)),
      Text(value, style: const TextStyle(color: MapColors.text, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: MapColors.text)),
    const SizedBox(width: 12),
    const Text('تفاصيل الحدث', style: TextStyle(color: MapColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
