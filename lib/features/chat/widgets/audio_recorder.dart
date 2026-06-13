import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';

class AudioRecorder extends StatefulWidget {
  final Function(Duration) onSend;

  const AudioRecorder({super.key, required this.onSend});

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> with SingleTickerProviderStateMixin {
  bool _recording = false;
  Duration _duration = Duration.zero;
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _toggle() {
    HapticFeedback.mediumImpact();
    if (_recording) {
      widget.onSend(_duration);
    }
    setState(() {
      _recording = !_recording;
      if (_recording) {
        _duration = Duration.zero;
        _startTimer();
      }
    });
  }

  void _startTimer() async {
    while (_recording && mounted) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && _recording) {
        setState(() => _duration += const Duration(seconds: 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (_, child) => Transform.scale(
          scale: _recording ? 1.0 + _pulse.value * 0.2 : 1.0,
          child: Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: _recording ? Colors.red : ChatColors.accent,
              shape: BoxShape.circle,
            ),
            child: Icon(_recording ? Icons.stop : Icons.mic, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }
}
