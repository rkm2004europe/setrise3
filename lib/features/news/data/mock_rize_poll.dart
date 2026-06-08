import '../models/rize_poll_model.dart';

final mockPoll = RizePollModel(
  question: 'أي منصة تفضل لنشر المحتوى؟',
  options: [
    RizePollOption(text: 'Threads', votes: 45),
    RizePollOption(text: 'Twitter/X', votes: 30),
    RizePollOption(text: 'SetRise', votes: 78),
    RizePollOption(text: 'Instagram', votes: 22),
  ],
  expiresAt: DateTime.now().add(const Duration(days: 1)),
);
