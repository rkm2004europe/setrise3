import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
// import '../../../profile/screens/edit_profile_screen.dart'; // مستقبلًا
// import '../../../auth/screens/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = true; // دائمًا داكن في هذا التطبيق
  bool _isPrivateAccount = false;
  bool _notificationsLikes = true;
  bool _notificationsComments = true;
  bool _notificationsFollows = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SettingsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, color: SettingsColors.textPrimary, size: 22),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: SettingsColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: SettingsColors.border, height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  // ── قسم الحساب ──
                  _buildSectionHeader('Account'),
                  _buildTile(
                    icon: Icons.person_outline,
                    title: 'Personal Information',
                    subtitle: 'Name, username, bio, avatar',
                    onTap: () {
                      // TODO: edit profile
                    },
                  ),
                  _buildTile(
                    icon: Icons.lock_outline,
                    title: 'Privacy & Security',
                    subtitle: 'Password, two-factor authentication',
                    onTap: () {
                      // TODO: privacy settings
                    },
                  ),
                  _buildSwitchTile(
                    icon: Icons.visibility_off_outlined,
                    title: 'Private Account',
                    subtitle: 'Only approved followers can see your content',
                    value: _isPrivateAccount,
                    onChanged: (v) => setState(() => _isPrivateAccount = v),
                  ),
                  _buildTile(
                    icon: Icons.block_outlined,
                    title: 'Blocked Accounts',
                    subtitle: 'Manage blocked users',
                    onTap: () {
                      // TODO: blocked list
                    },
                  ),
                  _buildTile(
                    icon: Icons.flag_outlined,
                    title: 'Report a Problem',
                    subtitle: 'Report a technical issue or abuse',
                    onTap: () {
                      // TODO: report
                    },
                  ),

                  const SizedBox(height: 24),
                  // ── قسم الإشعارات ──
                  _buildSectionHeader('Notifications'),
                  _buildSwitchTile(
                    icon: Icons.favorite_border,
                    title: 'Likes',
                    subtitle: 'When someone likes your content',
                    value: _notificationsLikes,
                    onChanged: (v) => setState(() => _notificationsLikes = v),
                  ),
                  _buildSwitchTile(
                    icon: Icons.chat_bubble_outline,
                    title: 'Comments',
                    subtitle: 'When someone comments on your posts',
                    value: _notificationsComments,
                    onChanged: (v) => setState(() => _notificationsComments = v),
                  ),
                  _buildSwitchTile(
                    icon: Icons.person_add_outlined,
                    title: 'Follows',
                    subtitle: 'When someone follows you',
                    value: _notificationsFollows,
                    onChanged: (v) => setState(() => _notificationsFollows = v),
                  ),

                  const SizedBox(height: 24),
                  // ── قسم المحتوى ──
                  _buildSectionHeader('Content'),
                  _buildTile(
                    icon: Icons.tune,
                    title: 'Content Preferences',
                    subtitle: 'Filter content by mood, region, and categories',
                    onTap: () {
                      // TODO: open filter sheet
                    },
                  ),
                  _buildTile(
                    icon: Icons.history,
                    title: 'Watch History',
                    subtitle: 'Clear or manage your view history',
                    onTap: () {
                      // TODO: clear history
                    },
                  ),
                  _buildSwitchTile(
                    icon: Icons.play_circle_outline,
                    title: 'Autoplay Videos',
                    subtitle: 'Play videos automatically',
                    value: true,
                    onChanged: (v) {
                      setState(() {}); // وهمي
                    },
                  ),

                  const SizedBox(height: 24),
                  // ── قسم الدعم ──
                  _buildSectionHeader('Support & About'),
                  _buildTile(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    subtitle: 'FAQs and tutorials',
                    onTap: () {},
                  ),
                  _buildTile(
                    icon: Icons.info_outline,
                    title: 'About SetRise',
                    subtitle: 'Version 1.0.0, build 2026',
                    onTap: () {},
                  ),
                  _buildTile(
                    icon: Icons.rate_review_outlined,
                    title: 'Rate Us',
                    subtitle: 'Leave a review',
                    onTap: () {},
                  ),

                  const SizedBox(height: 24),
                  // ── تسجيل الخروج ──
                  _buildTile(
                    icon: Icons.logout,
                    title: 'Log Out',
                    subtitle: 'Sign out of your account',
                    iconColor: SettingsColors.red,
                    textColor: SettingsColors.red,
                    onTap: () {
                      _showLogoutConfirmation();
                    },
                  ),
                  const SizedBox(height: 16),
                  // حذف الحساب
                  _buildTile(
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    subtitle: 'Permanently remove your account and data',
                    iconColor: SettingsColors.red,
                    textColor: SettingsColors.red,
                    onTap: () {
                      _showDeleteAccountConfirmation();
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: SettingsColors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? SettingsColors.textPrimary, size: 24),
      title: Text(title, style: TextStyle(color: textColor ?? SettingsColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: SettingsColors.textSecondary, fontSize: 12)) : null,
      trailing: const Icon(Icons.chevron_right, color: SettingsColors.textSecondary, size: 20),
      onTap: onTap ?? () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: SettingsColors.textPrimary, size: 24),
      title: Text(title, style: const TextStyle(color: SettingsColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(color: SettingsColors.textSecondary, fontSize: 12)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: SettingsColors.textPrimary,
        activeTrackColor: SettingsColors.textPrimary.withOpacity(0.4),
        inactiveThumbColor: SettingsColors.textSecondary,
        inactiveTrackColor: SettingsColors.border,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: SettingsColors.surface,
        title: const Text('Log Out', style: TextStyle(color: SettingsColors.textPrimary)),
        content: const Text('Are you sure you want to log out?', style: TextStyle(color: SettingsColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: SettingsColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: perform logout
            },
            child: const Text('Log Out', style: TextStyle(color: SettingsColors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: SettingsColors.surface,
        title: const Text('Delete Account', style: TextStyle(color: SettingsColors.red)),
        content: const Text('This will permanently delete your account and all data. This action cannot be undone.', style: TextStyle(color: SettingsColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: SettingsColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: delete account
            },
            child: const Text('Delete', style: TextStyle(color: SettingsColors.red)),
          ),
        ],
      ),
    );
  }
}
