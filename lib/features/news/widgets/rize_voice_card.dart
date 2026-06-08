import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RizeVoiceCard extends StatefulWidget {
  final String title;
  final Duration duration;
  const RizeVoiceCard({super.key, required this.title, required this.duration});

  @override
  State<RizeVoiceCard> createState() => _RizeVoiceCardState();
}

class _RizeVoiceCardState extends State<RizeVoiceCard> with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: NewsColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NewsColors.border),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => _isPlaying = !_isPlaying),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: NewsColors.accent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: const TextStyle(
                        color: NewsColors.textPrimary,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (_, __) => Row(
                    children: List.generate(15, (index) {
                      final height = (_waveController.value * 20 * (index % 3 + 1))
                          .clamp(4.0, 28.0);
                      return Container(
                        width: 3,
                        height: height,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: NewsColors.accent.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${widget.duration.inMinutes}:${(widget.duration.inSeconds % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(color: NewsColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
