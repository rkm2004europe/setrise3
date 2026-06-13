class NotificationService {
  Future<void> sendPush(String userId, String title, String body) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: firebase
  }
}
