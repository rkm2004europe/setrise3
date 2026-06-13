class VoiceToTextService {
  Future<String> transcribe() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'هذا نص محاكى من الصوت.';
  }
}
