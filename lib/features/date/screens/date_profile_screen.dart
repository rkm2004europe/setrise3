import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/date_user_model.dart';

class DateProfileScreen extends StatelessWidget {
  final DateUserModel user;

  const DateProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // صورة كبيرة
              Stack(
                children: [
                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      color: DateColors.surface,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: Text(user.photos[0], style: const TextStyle(fontSize: 150)),
                    ),
                  ),
                  // زر الرجوع
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
              // معلومات
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${user.name}، ${user.age}',
                          style: const TextStyle(
                            color: DateColors.text,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (user.isVerified)
                          const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.verified, color: DateColors.accent, size: 22),
                          ),
                      ],
                    ),
                    if (user.jobTitle != null) ...[
                      const SizedBox(height: 4),
                      Text(user.jobTitle!, style: const TextStyle(color: DateColors.text2)),
                    ],
                    if (user.education != null) ...[
                      const SizedBox(height: 2),
                      Text(user.education!, style: const TextStyle(color: DateColors.text2, fontSize: 12)),
                    ],
                    const SizedBox(height: 10),
                    Text(user.bio, style: const TextStyle(color: DateColors.text, height: 1.5)),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: user.interests.map((i) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: DateColors.accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(i, style: const TextStyle(color: DateColors.accent)),
                      )).toList(),
                    ),
                    const SizedBox(height: 24),
                    // أزرار Like / Nope
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: DateColors.nope.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: DateColors.nope, width: 1.5),
                              ),
                              child: const Center(
                                child: Text('تخطي', style: TextStyle(color: DateColors.nope, fontWeight: FontWeight.w800)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // TODO: trigger match and open chat
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: DateColors.like,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Text('إعجاب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
