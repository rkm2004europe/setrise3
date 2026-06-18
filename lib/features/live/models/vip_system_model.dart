class VipLevel {
  final String name;
  final int requiredCoins;
  final Color badgeColor;
  final String badgeIcon;
  final List<String> perks; // مزايا خاصة

  const VipLevel({
    required this.name,
    required this.requiredCoins,
    required this.badgeColor,
    required this.badgeIcon,
    required this.perks,
  });
}

// مستويات VIP
const List<VipLevel> vipLevels = [
  VipLevel(name: 'VIP', requiredCoins: 100, badgeColor: LiveColors.gold, badgeIcon: '⭐', perks: ['شارة VIP', 'دخول الغرف المميزة', 'رموز تعبيرية حصرية']),
  VipLevel(name: 'Gold VIP', requiredCoins: 500, badgeColor: LiveColors.gold, badgeIcon: '🌟', perks: ['كل مزايا VIP', 'أولوية في الدردشة', 'هدية يومية مجانية']),
  VipLevel(name: 'Diamond VIP', requiredCoins: 2000, badgeColor: LiveColors.diamond, badgeIcon: '💎', perks: ['كل مزايا Gold', 'مدير في الغرف', 'خصم 20% على الهدايا']),
  VipLevel(name: 'Legend', requiredCoins: 10000, badgeColor: Color(0xFFFF4500), badgeIcon: '👑', perks: ['كل المزايا', 'غرفة خاصة', 'مدير عام', 'ربح من البثوث']),
];
