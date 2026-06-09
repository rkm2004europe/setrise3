import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_rize_events.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: NewsColors.textPrimary, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Text('Events', style: TextStyle(color: NewsColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockEvents.length,
                itemBuilder: (context, index) {
                  final event = mockEvents[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: NewsColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: NewsColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.title, style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text(event.description, style: const TextStyle(color: NewsColors.textSecondary)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.people, color: NewsColors.accent, size: 16),
                            const SizedBox(width: 4),
                            Text('${event.participantsCount} participants', style: const TextStyle(color: NewsColors.accent, fontSize: 12)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(color: NewsColors.accent, borderRadius: BorderRadius.circular(20)),
                                child: const Text('Participate', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
