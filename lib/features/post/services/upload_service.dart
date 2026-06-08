import 'dart:async';

class UploadService {
  double _progress = 0.0;
  Stream<double> get uploadProgress => _progressStreamController.stream;
  final _progressStreamController = StreamController<double>.broadcast();

  Future<String?> uploadMedia(String filePath) async {
    // Simulate upload with progress
    for (var i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      _progress = i / 100.0;
      _progressStreamController.add(_progress);
    }
    // Return a fake URL after upload
    return 'https://setrise.app/media/uploaded_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  void dispose() {
    _progressStreamController.close();
  }
}
