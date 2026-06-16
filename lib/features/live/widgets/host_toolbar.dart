import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HostToolbar extends StatelessWidget {
  final VoidCallback onSettings;
  final VoidCallback onInvite;
  final VoidCallback onShop;
  final VoidCallback onEnd;

  const HostToolbar({super.key, required this.onSettings, required this.onInvite, required this.onShop, required this.onEnd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), borderRadius: BorderRadius.circular(16)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _tool(Icons.settings, 'إعدادات', onSettings),
        _tool(Icons.person_add, 'دعوة', onInvite),
        _tool(Icons.shopping_bag, 'متجر', onShop),
        _tool(Icons.call_end, 'إنهاء', onEnd, color: LiveColors.accent),
      ]),
    );
  }

  Widget _tool(IconData icon, String label, VoidCallback onTap, {Color? color}) => GestureDetector(
    onTap: onTap,
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: color ?? LiveColors.text, size: 22),
      const SizedBox(height: 2),
      Text(label, style: TextStyle(color: color ?? LiveColors.text2, fontSize: 10)),
    ]),
  );
}
