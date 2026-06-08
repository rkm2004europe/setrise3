class RizePollOption {
  final String text;
  int votes;
  RizePollOption({required this.text, this.votes = 0});
}

class RizePollModel {
  final String question;
  final List<RizePollOption> options;
  final DateTime expiresAt;

  RizePollModel({
    required this.question,
    required this.options,
    required this.expiresAt,
  });
}
