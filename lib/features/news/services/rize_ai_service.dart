class RizeAIService {
  Future<List<String>> generateSuggestions(String input) async {
    if (input.isEmpty) return [];
    await Future.delayed(const Duration(milliseconds: 500));
    // محاكاة اقتراحات
    return ['Check this out! 🔥', 'What do you think? 🤔', 'Interesting take!', 'Share your thoughts'];
  }
}
