Enterimport 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../data/formatters.dart';
import '../../settings/screens/settings_screen.dart';
import '../../user/screens/user_preview_sheet.dart';
import '../../shar/screens/share_sheet.dart';
// import '../../player/screens/set_screen.dart';
// import '../../news/screens/rize_screen.dart';
// import '../../shop/screens/shop_screen.dart';
// import '../../music/screens/music_screen.dart';
// import '../../comment/screens/comments_screen.dart';
// import '../../chat/screens/messages_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId; // null or 'me' means own profile
  const ProfileScreen({super.key, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  bool get _isMe => widget.userId == null || widget.userId == 'me';

  // بيانات وهمية (ستستبدل بالخدمات لاحقًا)
  int _postsCount = 47;
  int _followersCount = 1234;
  int _followingCount = 380;
  String _displayName = _isMe ? 'You' : 'Creator Name';
  String _username = _isMe ? '@you' : '@creator_handle';
  String _bio = 'Just dropped the new SetRise update 🔥 #setrise #tech';

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(
      length: _isMe ? 4 : 6,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  List<Widget> get _tabs {
    if (_isMe) {
      return const [
        Tab(icon: Icon(Icons.grid_on, size: 22)),
        Tab(icon: Icon(Icons.bookmark_border, size: 22)),
        Tab(icon: Icon(Icons.music_note, size: 22)),
        Tab(icon: Icon(Icons.shopping_bag_outlined, size: 22)),
      ];
    } else {
      return const [
        Tab(icon: Icon(Icons.videocam, size: 22)),
        Tab(icon: Icon(Icons.music_note, size: 22)),
        Tab(icon: Icon(Icons.article, size: 22)),
        Tab(icon: Icon(Icons.shopping_bag, size: 22)),
        Tab(icon: Icon(Icons.chat_bubble, size: 22)),
        Tab(icon: Icon(Icons.explore, size: 22)),
      ];
    }
  }

  List<Widget> get _tabViews {
    if (_isMe) {
      return [
        _buildSetRizeGrid(),
        _buildSavedGrid(),
        _buildMusicList(),
        _buildShopGrid(),
      ];
    } else {
      return [
        _buildSetRizeGrid(),
        _buildMusicList(),
        _buildRizeList(),
        _buildShopGrid(),
        _buildCommentsList(),
        _buildExploreGrid(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Column(
                children: [
                  // Top bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Row(
                      children: [
                        Text(_isMe ? 'Profile' : _displayName,
                            style: ProfileTextStyles.h4.copyWith(color: ProfileColors.textPrimary)),
                        const Spacer(),
                        if (_isMe)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const SettingsScreen()),
                              );
                            },
                            child: const Icon(Icons.settings_outlined, color: ProfileColors.textPrimary, size: 24),
                          )
                        else
                          IconButton(
                            icon: const Icon(Icons.more_horiz, color: ProfileColors.textPrimary),
                            onPressed: () {
                              _showMoreOptions();
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Avatar + Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar
                        Stack(
                          children: [
                            Container(
                              width: 86,
                              height: 86,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: ProfileColors.border, width: 2),
                                color: ProfileColors.surface,
                              ),
                              child: const Icon(Icons.person, color: ProfileColors.textSecondary, size: 48),
                            ),
                            if (_isMe)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: ProfileColors.accent,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: ProfileColors.background, width: 2),
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _stat(Formatters.formatCount(_postsCount), 'Posts'),
                              _stat(Formatters.formatCount(_followersCount), 'Followers'),
                              _stat(Formatters.formatCount(_followingCount), 'Following'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Bio
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_displayName, style: ProfileTextStyles.labelLarge.copyWith(color: ProfileColors.textPrimary)),
                        Text(_username, style: ProfileTextStyles.body2.copyWith(color: ProfileColors.textSecondary)),
                        const SizedBox(height: 6),
                        Text(_bio, style: ProfileTextStyles.body2.copyWith(color: ProfileColors.textPrimary, height: 1.4)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _isMe
                        ? Row(
                            children: [
                              Expanded(child: _outlineBtn('Edit Profile', () {
                                // TODO: edit profile
                              })),
                              const SizedBox(width: 8),
                              Expanded(child: _outlineBtn('Share Profile', () {
                                ShareSheet.show(context, data: ShareData(
                                  id: widget.userId ?? 'me',
                                  title: _displayName,
                                  subtitle: _bio,
                                  accentColor: ProfileColors.accent,
                                  link: 'https://setrise.app/profile/${widget.userId ?? 'me'}',
                                ));
                              })),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: _filledBtn('Follow', () {
                                  setState(() {
                                    _followersCount += 1; // وهمي
                                  });
                                  HapticFeedback.mediumImpact();
                                }),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: _outlineBtn('Message', () {
                                  // TODO: open chat
                                }),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 3,
                                child: _outlineBtn('View Shop', () {
                                  // TODO: open user shop
                                }),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabCtrl,
                indicatorColor: ProfileColors.textPrimary,
                indicatorWeight: 2,
                labelColor: ProfileColors.textPrimary,
                unselectedLabelColor: ProfileColors.textSecondary,
                tabs: _tabs,
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabCtrl,
          children: _tabViews,
        ),
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(value, style: ProfileTextStyles.h5.copyWith(color: ProfileColors.textPrimary)),
        const SizedBox(height: 2),
        Text(label, style: ProfileTextStyles.labelSmall.copyWith(color: ProfileColors.textSecondary)),
      ],
    );
  }

  Widget _outlineBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          border: Border.all(color: ProfileColors.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(label, style: ProfileTextStyles.labelMedium.copyWith(color: ProfileColors.textPrimary)),
        ),
      ),
    );
  }

  Widget _filledBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: ProfileColors.accent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(label, style: ProfileTextStyles.labelMedium.copyWith(color: Colors.white)),
        ),
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ProfileColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.flag_outlined, color: Colors.orangeAccent),
              title: const Text('Report User', style: TextStyle(color: Colors.orangeAccent)),
              onTap: () { Navigator.pop(context); /* TODO: report */ },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: Colors.redAccent),
              title: const Text('Block User', style: TextStyle(color: Colors.redAccent)),
              onTap: () { Navigator.pop(context); /* TODO: block */ },
            ),
            ListTile(
              leading: const Icon(Icons.link, color: ProfileColors.textSecondary),
              title: const Text('Copy Profile Link', style: TextStyle(color: ProfileColors.textSecondary)),
              onTap: () {
                Clipboard.setData(ClipboardData(text: 'https://setrise.app/profile/${widget.userId}'));
                Navigator.pop(context);
                HapticFeedback.selectionClick();
              },
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────── التبويبات ───────────────
  Widget _buildSetRizeGrid() {
    final List<Color> colors = [
      Color(0xFF1A0A2E), Color(0xFF0A1628), Color(0xFF1A0A0A),
      Color(0xFF0A1A0A), Color(0xFF1A1A0A), Color(0xFF2E0A1A),
      Color(0xFF0A2E2E), Color(0xFF2E1A0A), Color(0xFF001A2E),
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2,
      ),
      itemCount: colors.length,
      itemBuilder: (_, i) => GestureDetector(
        onTap: () {
          // TODO: navigate to player
        },
        child: Container(
          color: colors[i],
          child: Stack(
            children: [
              Center(child: Icon(Icons.play_arrow, color: Colors.white.withOpacity(0.2), size: 32)),
              Positioned(
                bottom: 6, left: 6,
                child: Row(children: [
                  const Icon(Icons.play_arrow, color: Colors.white, size: 12),
                  const SizedBox(width: 2),
                  Text(Formatters.formatCount((i + 1) * 1200),
                      style: const TextStyle(color: Colors.white, fontSize: 10)),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSavedGrid() => const Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.bookmark_border, color: ProfileColors.textSecondary, size: 48),
          SizedBox(height: 12),
          Text('No saved posts yet', style: TextStyle(color: ProfileColors.textSecondary)),
        ]),
      );

  Widget _buildMusicList() => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 5,
        itemBuilder: (_, i) => ListTile(
          leading: Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: ProfileColors.music.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.music_note, color: ProfileColors.music),
          ),
          title: Text('Track ${i + 1}', style: const TextStyle(color: ProfileColors.textPrimary)),
          subtitle: Text('Artist', style: TextStyle(color: ProfileColors.textSecondary)),
          trailing: const Icon(Icons.play_arrow, color: ProfileColors.textPrimary),
          onTap: () { /* TODO: open music */ },
        ),
      );

  Widget _buildShopGrid() {
    final List<Color> colors = [
      Color(0xFFFF9500), Color(0xFF34C759), Color(0xFF007AFF), Color(0xFFFF2D55)
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2,
      ),
      itemCount: colors.length,
      itemBuilder: (_, i) => GestureDetector(
        onTap: () { /* TODO: open shop */ },
        child: Container(
          color: colors[i].withOpacity(0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag, color: colors[i], size: 32),
              const SizedBox(height: 4),
              Text('Item ${i + 1}', style: TextStyle(color: colors[i], fontSize: 12)),
              Text('\$ ${(i+1)*10}', style: TextStyle(color: ProfileColors.textSecondary, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRizeList() => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 6,
        itemBuilder: (_, i) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ProfileColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ProfileColors.border),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Post ${i+1}', style: const TextStyle(color: ProfileColors.textPrimary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('This is a sample Rize post content. #trending', style: TextStyle(color: ProfileColors.textSecondary)),
          ]),
        ),
      );

  Widget _buildCommentsList() => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 8,
        itemBuilder: (_, i) => ListTile(
          leading: CircleAvatar(
            backgroundColor: ProfileColors.accent.withOpacity(0.1),
            child: Icon(Icons.comment, color: ProfileColors.accent),
          ),
          title: Text('Comment ${i+1}', style: const TextStyle(color: ProfileColors.textPrimary)),
          subtitle: Text('On: Post title', style: TextStyle(color: ProfileColors.textSecondary)),
          onTap: () { /* TODO: open comments */ },
        ),
      );

  Widget _buildExploreGrid() {
    final List<Color> colors = [
      Color(0xFF6C63FF), Color(0xFFFF2D55), Color(0xFFFF9500), Color(0xFF34C759)
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2,
      ),
      itemCount: colors.length,
      itemBuilder: (_, i) => Container(
        color: colors[i].withOpacity(0.1),
        child: Center(child: Icon(Icons.explore, color: colors[i], size: 40)),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: ProfileColors.background, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
