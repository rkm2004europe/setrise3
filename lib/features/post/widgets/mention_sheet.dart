import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class MentionSheet extends StatefulWidget {
  final Function(String username) onMentionSelected;
  const MentionSheet({super.key, required this.onMentionSelected});

  @override
  State<MentionSheet> createState() => _MentionSheetState();
}

class _MentionSheetState extends State<MentionSheet> {
  final _searchCtrl = TextEditingController();
  final List<Map<String, String>> _users = [
    {'username': '@ahmed_k', 'name': 'Ahmed K.'},
    {'username': '@sara_m', 'name': 'Sara M.'},
    {'username': '@omar_t', 'name': 'Omar T.'},
    {'username': '@lina_r', 'name': 'Lina R.'},
    {'username': '@nora_x', 'name': 'Nora X.'},
  ];

  late List<Map<String, String>> _filteredUsers = _users;

  void _filter(String query) {
    setState(() {
      _filteredUsers = _users
          .where((u) =>
              u['username']!.toLowerCase().contains(query.toLowerCase()) ||
              u['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PostColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4,
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchCtrl,
                style: const TextStyle(color: PostColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search user...',
                  hintStyle: TextStyle(color: PostColors.textSecondary),
                  prefixIcon: const Icon(Icons.person_add, color: PostColors.textSecondary),
                  filled: true,
                  fillColor: PostColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: _filter,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = _filteredUsers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: PostColors.accent.withOpacity(0.2),
                      child: Text(user['name']![0],
                          style: const TextStyle(
                              color: PostColors.accent,
                              fontWeight: FontWeight.bold)),
                    ),
                    title: Text(user['username']!,
                        style: const TextStyle(
                            color: PostColors.textPrimary,
                            fontWeight: FontWeight.w600)),
                    subtitle: Text(user['name']!,
                        style: const TextStyle(color: PostColors.textSecondary)),
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      widget.onMentionSelected(user['username']!);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
