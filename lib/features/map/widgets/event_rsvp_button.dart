import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EventRsvpButton extends StatefulWidget {
  final bool isAttending;
  final VoidCallback onToggle;
  const EventRsvpButton({super.key, required this.isAttending, required this.onToggle});

  @override
  State<EventRsvpButton> createState() => _EventRsvpButtonState();
}

class _EventRsvpButtonState extends State<EventRsvpButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: widget.isAttending ? MapColors.green : MapColors.accent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          widget.isAttending ? 'تم التأكيد' : 'تأكيد الحضور',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
