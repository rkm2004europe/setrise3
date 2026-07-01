class PlayerService {
  Future<void> play(String url) async { await Future.delayed(const Duration(milliseconds: 100)); }
  Future<void> pause() async {}
  Future<void> seek(Duration position) async {}
}
