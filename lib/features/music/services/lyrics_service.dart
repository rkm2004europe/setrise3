class LyricsService {
  Future<String> fetchLyrics(String trackId) async {
    await Future.delayed(const Duration(seconds: 1));
    return '[المقطع الأول]\nالكلمات هنا...\n\n[الكورس]\nالكلمات هنا...';
  }
}
