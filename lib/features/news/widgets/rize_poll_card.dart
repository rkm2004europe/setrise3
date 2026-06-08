import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/rize_poll_model.dart';

class RizePollCard extends StatefulWidget {
  final RizePollModel poll;
  const RizePollCard({super.key, required this.poll});

  @override
  State<RizePollCard> createState() => _RizePollCardState();
}

class _RizePollCardState extends State<RizePollCard> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final totalVotes = widget.poll.options.fold<int>(0, (sum, o) => sum + o.votes);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: NewsColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NewsColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.poll.question, style: const TextStyle(color: NewsColors.textPrimary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...widget.poll.options.map((option) {
            final percentage = totalVotes > 0 ? option.votes / totalVotes : 0.0;
            final isSelected = _selectedOption == widget.poll.options.indexOf(option);
            return GestureDetector(
              onTap: () => setState(() => _selectedOption = widget.poll.options.indexOf(option)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? NewsColors.accent.withOpacity(0.1) : NewsColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? NewsColors.accent : NewsColors.border),
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(option.text, style: const TextStyle(color: NewsColors.textPrimary))),
                    if (isSelected || _selectedOption != null)
                      Text('${(percentage * 100).round()}%',
                          style: const TextStyle(color: NewsColors.textSecondary)),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 4),
          Text('$totalVotes votes', style: const TextStyle(color: NewsColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}
