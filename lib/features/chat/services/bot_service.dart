class BotService {
  Future<String> getReply(String message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (message.contains('مرحباً')) return 'أهلاً بك!';
    return 'شكراً لتواصلك.';
  }
}
