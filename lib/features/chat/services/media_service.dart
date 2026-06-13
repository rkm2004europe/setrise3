class MediaService {
  Future<String> uploadMedia(String path) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'https://setrise.app/media/uploaded';
  }
}
