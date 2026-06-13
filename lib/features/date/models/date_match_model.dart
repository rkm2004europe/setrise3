class DateMatchModel {
  final String id;
  final String userId;
  final String matchedUserId;
  final DateTime matchedAt;
  final String? icebreakerQuestion;
  bool conversationStarted;

  DateMatchModel({
    required this.id,
    required this.userId,
    required this.matchedUserId,
    required this.matchedAt,
    this.icebreakerQuestion,
    this.conversationStarted = false,
  });
}
