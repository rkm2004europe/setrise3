import 'package:flutter/material.dart';
import '../theme/colors.dart';

class PinMessageSheet {
  static void show(BuildContext context, {required VoidCallback onPin}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ChatColors.surface,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.push_pin, color: ChatColors.text),
              title: const Text('تثبيت الرسالة', style: TextStyle(color: ChatColors.text)),
              onTap: () { Navigator.pop(context); onPin(); },
            ),
            ListTile(
              leading: const Icon(Icons.push_pin_outlined, color: ChatColors.text2),
              title: const Text('إلغاء التثبيت', style: TextStyle(color: ChatColors.text)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
