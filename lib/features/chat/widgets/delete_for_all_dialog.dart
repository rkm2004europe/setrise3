import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DeleteForAllDialog {
  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: ChatColors.surface,
        title: const Text('حذف للجميع', style: TextStyle(color: ChatColors.text)),
        content: const Text('سيتم حذف الرسالة من كل الأجهزة.', style: TextStyle(color: ChatColors.text2)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('إلغاء', style: TextStyle(color: ChatColors.text2))),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('حذف', style: TextStyle(color: Colors.redAccent))),
        ],
      ),
    ) ?? false;
  }
}
