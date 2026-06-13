import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';

class OptionsSheet {
  static void show(BuildContext context, {
    required Message message,
    required Function(String) onReact,
    required VoidCallback onReply,
    required VoidCallback onCopy,
    required VoidCallback onDeleteForMe,
    required VoidCallback? onDeleteForAll,
    required VoidCallback? onEdit,
    required VoidCallback? onPin,
  }) {
    final isMe = message.isMe;
    showModalBottomSheet(
      context: context,
      backgroundColor: ChatColors.surface,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(leading: const Icon(Icons.reply, color: ChatColors.text), title: const Text('رد', style: TextStyle(color: ChatColors.text)), onTap: () { Navigator.pop(context); onReply(); }),
            ListTile(leading: const Icon(Icons.copy, color: ChatColors.text), title: const Text('نسخ', style: TextStyle(color: ChatColors.text)), onTap: () { Navigator.pop(context); onCopy(); }),
            if (isMe && onEdit != null)
              ListTile(leading: const Icon(Icons.edit, color: ChatColors.text), title: const Text('تعديل', style: TextStyle(color: ChatColors.text)), onTap: () { Navigator.pop(context); onEdit(); }),
            if (onPin != null)
              ListTile(leading: const Icon(Icons.push_pin, color: ChatColors.text), title: const Text('تثبيت', style: TextStyle(color: ChatColors.text)), onTap: () { Navigator.pop(context); onPin(); }),
            ListTile(leading: const Icon(Icons.delete, color: Colors.redAccent), title: const Text('حذف لي', style: TextStyle(color: Colors.redAccent)), onTap: () { Navigator.pop(context); onDeleteForMe(); }),
            if (isMe && onDeleteForAll != null)
              ListTile(leading: const Icon(Icons.delete_forever, color: Colors.redAccent), title: const Text('حذف للجميع', style: TextStyle(color: Colors.redAccent)), onTap: () { Navigator.pop(context); onDeleteForAll(); }),
          ],
        ),
      ),
    );
  }
}
