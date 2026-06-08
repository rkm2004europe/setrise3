import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_rize_communities.dart';
import '../models/rize_community_model.dart';

class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  late List<RizeCommunityModel> _communities;

  @override
  void initState() {
    super.initState();
    _communities = List.from(mockCommunities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewsColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _communities.length,
                itemBuilder: (context, index) {
                  final community = _communities[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: NewsColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: NewsColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: NewsColors.accent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.group, color: NewsColors.accent),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                community.name,
                                style: const TextStyle(
                                  color: NewsColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  final idx = _communities.indexWhere((c) => c.id == community.id);
                                  if (idx != -1) {
                                    _communities[idx] = RizeCommunityModel(
                                      id: community.id,
                                      name: community.name,
                                      description: community.description,
                                      membersCount: community.membersCount,
                                      isJoined: !community.isJoined,
                                    );
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: community.isJoined ? NewsColors.surface : NewsColors.accent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: community.isJoined ? NewsColors.border : NewsColors.accent),
                                ),
                                child: Text(
                                  community.isJoined ? 'Joined' : 'Join',
                                  style: TextStyle(
                                    color: community.isJoined ? NewsColors.textPrimary : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          community.description,
                          style: const TextStyle(color: NewsColors.textSecondary, fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${_formatNumber(community.membersCount)} members',
                          style: const TextStyle(color: NewsColors.textSecondary, fontSize: 11),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: NewsColors.textPrimary, size: 20),
          ),
          const SizedBox(width: 8),
          const Text(
            'Communities',
            style: TextStyle(
              color: NewsColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}
