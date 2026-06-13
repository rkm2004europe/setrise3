import 'package:flutter/material.dart';
import '../theme/colors.dart';

class PollMessage extends StatefulWidget {
  final String question;
  final List<String> options;
  const PollMessage({super.key, required this.question, required this.options});

  @override
  State<PollMessage> createState() => _PollMessageState();
}

class _PollMessageState extends State<PollMessage> {
  int? _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: ChatColors.surface, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.question, style: const TextStyle(color: ChatColors.text, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...widget.options.asMap().entries.map((e) => GestureDetector(
            onTap: () => setState(() => _selected = e.key),
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: _selected == e.key ? ChatColors.accent.withOpacity(0.2) : ChatColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _selected == e.key ? ChatColors.accent : ChatColors.border),
              ),
              child: Text(e.value, style: TextStyle(color: _selected == e.key ? ChatColors.accent : ChatColors.text)),
            ),
          )),
        ],
      ),
    );
  }
}
