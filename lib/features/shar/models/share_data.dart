import 'package:flutter/material.dart';

class QuickShareUser {
  final String id;
  final String name;
  final String? avatarUrl;
  final Color? color; // لون الصورة الرمزية البديلة

  const QuickShareUser({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.color,
  });
}

class ShareOption {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const ShareOption({
    required this.icon,
    required this.label,
    this.color,
    required this.onTap,
  });
}

class ShareData {
  final String id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final String? link;
  final Color accentColor;

  /// قائمة مستخدمين للإرسال السريع (يظهرون بشكل أفقي)
  final List<QuickShareUser>? quickShareUsers;

  /// خيارات مخصصة إضافية تظهر في قسم "المزيد"
  final List<ShareOption>? customOptions;

  /// عمليات استدعاء مخصصة
  final VoidCallback? onShareToStory;
  final VoidCallback? onShareToProfile;
  final VoidCallback? onCopyLink;

  const ShareData({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.link,
    this.accentColor = const Color(0xFF6C63FF),
    this.quickShareUsers,
    this.customOptions,
    this.onShareToStory,
    this.onShareToProfile,
    this.onCopyLink,
  });
}
