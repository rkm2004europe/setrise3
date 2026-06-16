import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class VoiceRoomControls extends StatelessWidget {
  final bool isMuted;
  final bool hasRaisedHand;
  final VoidCallback onToggleMute;
  final VoidCallback onRaiseHand;
  final VoidCallback onLeave;

  const VoiceRoomControls({
    super.key,
    required this.isMuted,
    required this.hasRaisedHand,
    required this.onToggleMute,
    required this.onRaiseHand,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: LiveColors.surface, border: Border(top: BorderSide(color: LiveColors.border))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _buildBtn(Icons.mic_off, 'كتم', isMuted ? LiveColors.accent : LiveColors.text2, onToggleMute),
        _buildBtn(Icons.back_hand, 'رفع اليد', hasRaisedHand ? LiveColors.gold : LiveColors.text2, onRaiseHand),
        _buildBtn(Icons.call_end, 'مغادرة', LiveColors.accent, onLeave),
      ]),
    );
  }

  Widget _buildBtn(IconData icon, String label, Color color, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(width: 52, height: 52, decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: color, size: 24)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 11)),
      ],
    ),
  );
}
