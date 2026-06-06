import 'package:flutter/material.dart';

class _CommentColors {
  _CommentColors._();

  // خلفيات داكنة
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF1C1C1E);
  static const Color inputBackground = Color(0xFF2C2C2E);
  static const Color bottomSheet = Color(0xFF1C1C1E);

  // نصوص
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textHint = Color(0xFF636366);

  // حدود وفواصل
  static const Color border = Color(0xFF38383A);
  static const Color divider = Color(0xFF3A3A3C);

  // ألوان الإجراءات
  static const Color likeActive = Colors.red;
  static const Color deleteRed = Color(0xFFFF453A);
}

// هذا هو الكلاس الوحيد الذي ستستورده الشاشات
class CommentColors {
  static const background = _CommentColors.background;
  static const surface = _CommentColors.surface;
  static const inputBackground = _CommentColors.inputBackground;
  static const bottomSheet = _CommentColors.bottomSheet;
  static const textPrimary = _CommentColors.textPrimary;
  static const textSecondary = _CommentColors.textSecondary;
  static const textHint = _CommentColors.textHint;
  static const border = _CommentColors.border;
  static const divider = _CommentColors.divider;
  static const likeActive = _CommentColors.likeActive;
  static const deleteRed = _CommentColors.deleteRed;
}
