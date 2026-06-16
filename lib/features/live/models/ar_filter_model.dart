class ArFilterModel {
  final String id;
  final String name;
  final String thumbnailEmoji;
  final bool isPremium;

  ArFilterModel({required this.id, required this.name, required this.thumbnailEmoji, this.isPremium = false});
}
