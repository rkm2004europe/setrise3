class DateQuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final int totalVotes;

  DateQuestionModel({
    required this.id,
    required this.question,
    required this.options,
    this.totalVotes = 0,
  });
}
