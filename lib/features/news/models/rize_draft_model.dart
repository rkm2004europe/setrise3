class RizeDraftModel {
  final String id;
  final String text;
  final String? mediaPath;
  final DateTime savedAt;

  const RizeDraftModel({
    required this.id,
    required this.text,
    this.mediaPath,
    required this.savedAt,
  });
}
