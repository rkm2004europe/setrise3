import 'package:flutter/material.dart';
import '../theme/colors.dart';

class EditMessageBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const EditMessageBar({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: ChatColors.surface,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: ChatColors.text),
              decoration: InputDecoration(
                hintText: 'تعديل الرسالة...',
                hintStyle: TextStyle(color: ChatColors.text2.withOpacity(0.5)),
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(onPressed: onSave, child: const Text('حفظ', style: TextStyle(color: ChatColors.accent))),
          TextButton(onPressed: onCancel, child: const Text('إلغاء', style: TextStyle(color: ChatColors.text2))),
        ],
      ),
    );
  }
}
