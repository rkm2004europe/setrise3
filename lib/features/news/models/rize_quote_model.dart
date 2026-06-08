class RizeQuoteModel {
  final String id;
  final String originalPostId;
  final String quoterUserId;
  final String quoterUserName;
  final String quoterUsername;
  final String comment; // تعليق المضيف على المنشور المقتبس
  final DateTime createdAt;

  const RizeQuoteModel({
    required this.id,
    required this.originalPostId,
    required this.quoterUserId,
    required this.quoterUserName,
    required this.quoterUsername,
    required this.comment,
    required this.createdAt,
  });
}
