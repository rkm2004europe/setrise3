class ReplayService {
  Future<void> saveReplay(String roomId) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<Map<String, dynamic>> getReplayWithChat(String roomId) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'videoUrl': '', 'comments': []};
  }
}
