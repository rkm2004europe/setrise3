class RizeBadgeModel {
  final String id;
  final String name;
  final String description;
  final String icon; // emoji or icon name
  final bool isEarned;

  const RizeBadgeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.isEarned = false,
  });
}
