import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/speaker_model.dart';

class GuestGrid extends StatelessWidget {
  final List<SpeakerModel> guests;
  final Function(SpeakerModel) onGuestTap;

  const GuestGrid({super.key, required this.guests, required this.onGuestTap});

  @override
  Widget build(BuildContext context) {
    if (guests.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 10, runSpacing: 10,
      children: guests.map((guest) => GestureDetector(
        onTap: () => onGuestTap(guest),
        child: Container(
          width: 80,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            CircleAvatar(radius: 20, backgroundColor: LiveColors.accent.withOpacity(0.1), child: Text(guest.avatar, style: const TextStyle(fontSize: 18))),
            const SizedBox(height: 4),
            Text(guest.userName, style: const TextStyle(color: LiveColors.text, fontSize: 10), textAlign: TextAlign.center),
            if (guest.isMuted) const Icon(Icons.mic_off, color: LiveColors.text2, size: 12),
          ]),
        ),
      )).toList(),
    );
  }
}
