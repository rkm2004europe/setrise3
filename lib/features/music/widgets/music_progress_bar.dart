import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MusicProgressBar extends StatefulWidget {
  final Duration duration;
  const MusicProgressBar({super.key, required this.duration});

  @override
  State<MusicProgressBar> createState() => _MusicProgressBarState();
}

class _MusicProgressBarState extends State<MusicProgressBar> {
  double _progress = 0.4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            activeTrackColor: MusicColors.accent,
            inactiveTrackColor: MusicColors.text2.withOpacity(0.3),
            thumbColor: MusicColors.accent,
          ),
          child: Slider(value: _progress, onChanged: (v) => setState(() => _progress = v)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatTime(widget.duration * _progress), style: const TextStyle(color: MusicColors.text2, fontSize: 11)),
              Text(_formatTime(widget.duration), style: const TextStyle(color: MusicColors.text2, fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  String _formatTime(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
