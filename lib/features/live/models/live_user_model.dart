class LiveUserModel {
  final String id;
  final String name;
  final String avatar;
  final int level;
  final int xp;
  final int xpToNext;
  final String vipLevel;
  final int coins;
  final List<String> badges;
  final int followersCount;
  final int followingCount;

  LiveUserModel({
    required this.id,
    required this.name,
    required this.avatar,
    this.level = 1,
    this.xp = 0,
    this.xpToNext = 100,
    this.vipLevel = '',
    this.coins = 0,
    this.badges = const [],
    this.followersCount = 0,
    this.followingCount = 0,
  });
}
