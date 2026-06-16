enum VipTier { normal, vip, gold, diamond, moderator, host }

class VipUserModel {
  final String userId;
  final VipTier tier;

  VipUserModel({required this.userId, required this.tier});
}
