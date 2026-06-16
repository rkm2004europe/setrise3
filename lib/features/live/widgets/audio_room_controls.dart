import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AudioRoomControls extends StatelessWidget {
  final bool isMuted;
  final bool handRaised;
  final VoidCallback onToggleMute;
  final VoidCallback onToggleHand;

  const AudioRoomControls({
    super.key,
    required this.isMuted,
    required this.handRaised,
    required this.onToggleMute,
    required this.onToggleHand,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildControl(
          icon: isMuted ? Icons.mic_off : Icons.mic,
          label: isMuted ? 'كتم' : 'مايك مفتوح',
          color: isMuted ? LiveColors.text2 : LiveColors.accent,
          onTap: onToggleMute,
        ),
        const SizedBox(width: 30),
        _buildControl(
          icon: Icons.exit_to_app,
          label: 'مغادرة',
          color: LiveColors.text2,
          onTap: () => Navigator.pop(context),
        ),
        const SizedBox(width: 30),
        _buildControl(
          icon: handRaised ? Icons.pan_tool : Icons.pan_tool_outlined,
          label: handRaised ? 'يد مرفوعة' : 'رفع اليد',
          color: handRaised ? LiveColors.gold : LiveColors.text2,
          onTap: onToggleHand,
        ),
      ],
    );
  }

  Widget _buildControl({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
