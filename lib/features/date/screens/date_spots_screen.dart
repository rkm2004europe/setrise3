import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_date_spots.dart';

class DateSpotsScreen extends StatelessWidget {
  const DateSpotsScreen({super.key});

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
                itemCount: mockDateSpots.length,
                itemBuilder: (_, i) {
                  final spot = mockDateSpots[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: DateColors.surface, borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Container(width: 60, height: 60, decoration: BoxDecoration(color: DateColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: Center(child: Text(spot.imageEmoji, style: const TextStyle(fontSize: 32)))),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(spot.name, style: const TextStyle(color: DateColors.text, fontWeight: FontWeight.w700, fontSize: 16)),
                            Text('${spot.type} • ${spot.address}', style: const TextStyle(color: DateColors.text2, fontSize: 12)),
                            Row(children: [
                              const Icon(Icons.star, color: Colors.amber, size: 14),
                              Text(' ${spot.rating}', style: const TextStyle(color: DateColors.text2, fontSize: 12)),
                              const SizedBox(width: 12),
                              Text('${spot.checkins} تسجيل', style: const TextStyle(color: DateColors.text2, fontSize: 12)),
                            ]),
                          ]),
                        ),
                        Text('${spot.distance} كم', style: const TextStyle(color: DateColors.accent, fontWeight: FontWeight.w600)),
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

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: DateColors.text)),
      const SizedBox(width: 12),
      const Text('أماكن المواعدة', style: TextStyle(color: DateColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
