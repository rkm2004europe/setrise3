import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class VoiceRoomAnimatedAvatar extends StatefulWidget {
  final String avatar;
  final bool isSpeaking;
  const VoiceRoomAnimatedAvatar({super.key, required this.avatar, required this.isSpeaking});

  @override
  State<VoiceRoomAnimatedAvatar> createState() => _VoiceRoomAnimatedAvatarState();
}

class _VoiceRoomAnimatedAvatarState extends State<VoiceRoomAnimatedAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.12).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (_, child) => Transform.scale(
        scale: widget.isSpeaking ? _scale.value : 1.0,
        child: Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: LiveColors.accent.withOpacity(0.1),
            border: Border.all(color: widget.isSpeaking ? LiveColors.accent : LiveColors.border, width: 2),
          ),
          child: Center(child: Text(widget.avatar, style: const TextStyle(fontSize: 32))),
        ),
      ),
    );
  }
}
