class CloudService {
  Future<void> backup() async {
    await Future.delayed(const Duration(seconds: 2)); // محاكاة
  }

  Future<void> restore() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
