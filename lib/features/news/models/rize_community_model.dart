class RizeCommunityModel {
  final String id;
  final String name;
  final String description;
  final int membersCount;
  final bool isJoined;

  const RizeCommunityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.membersCount,
    this.isJoined = false,
  });
}
