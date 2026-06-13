class SyncService {
  Future<void> syncNow() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
