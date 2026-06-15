class XpModel {
  final int currentXp;
  final int level;
  final int xpToNextLevel;
  final List<String> badges;

  XpModel({
    required this.currentXp,
    required this.level,
    required this.xpToNextLevel,
    required this.badges,
  });
}
