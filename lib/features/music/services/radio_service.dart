class RadioService {
  Future<List<String>> getStations() async { await Future.delayed(const Duration(seconds: 1)); return ['Pop', 'Rock', 'Jazz']; }
}
