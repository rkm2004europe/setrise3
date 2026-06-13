class DateLocationService {
  Future<String> getCurrentCity() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'الجزائر العاصمة';
  }
}
