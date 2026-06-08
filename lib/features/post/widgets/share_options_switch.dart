import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ShareOptionsSwitch extends StatelessWidget {
  final bool shareToRize;
  final bool shareToNews;
  final ValueChanged<bool> onRizeChanged;
  final ValueChanged<bool> onNewsChanged;

  const ShareOptionsSwitch({
    super.key,
    required this.shareToRize,
    required this.shareToNews,
    required this.onRizeChanged,
    required this.onNewsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSwitch('Also post to Rize', shareToRize, onRizeChanged),
        const SizedBox(height: 8),
        _buildSwitch('Share to News Feed', shareToNews, onNewsChanged),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: PostColors.textPrimary)),
        const Spacer(),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: PostColors.accent,
        ),
      ],
    );
  }
}
