import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';

class OptionsSheet {
  static void show(BuildContext context, {required Message message, required Function(String) onReact, required VoidCallback onReply, required VoidCallback onDelete}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ChatColors.surface,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(leading: const Icon(Icons.reply, color: ChatColors.text), title: const Text('رد', style: TextStyle(color: ChatColors.text)), onTap: () { Navigator.pop(context); onReply(); }),
            ListTile(leading: const Icon(Icons.copy, color: ChatColors.text), title: const Text('نسخ', style: TextStyle(color: ChatColors.text)), onTap: () { Navigator.pop(context); }),
            ListTile(leading: const Icon(Icons.delete, color: Colors.redAccent), title: const Text('حذف', style: TextStyle(color: Colors.redAccent)), onTap: () { Navigator.pop(context); onDelete(); }),
          ],
        ),
      ),
    );
  }
}
