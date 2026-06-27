library;

import 'dart:io';

import 'package:gal/gal.dart';

class GallerySaveService {
  GallerySaveService();

  bool _isInitialised = false;

  Future<void> initialize() async {
    if (_isInitialised) return;
    _isInitialised = true;
  }

  Future<bool> requestPermission() async {
    await initialize();
    return Gal.hasAccess(toAlbum: true);
  }

  Future<String?> saveVideo(String videoPath, {String? albumName}) async {
    await initialize();

    if (!await Gal.hasAccess(toAlbum: true)) {
      final granted = await Gal.requestAccess(toAlbum: true);
      if (!granted) return null;
    }

    await Gal.putVideo(
      videoPath,
      album: albumName ?? 'Creator Studio',
    );
    return videoPath;
  }

  Future<String?> saveImage(String imagePath, {String? albumName}) async {
    await initialize();

    if (!await Gal.hasAccess(toAlbum: true)) {
      final granted = await Gal.requestAccess(toAlbum: true);
      if (!granted) return null;
    }

    await Gal.putImage(
      imagePath,
      album: albumName ?? 'Creator Studio',
    );
    return imagePath;
  }

  Future<String?> saveImageBytes(
    List<int> bytes, {
    required String filename,
    String? albumName,
  }) async {
    final tempDir = await Directory.systemTemp.createTemp('studio_save_');
    final tempPath = '${tempDir.path}/$filename';
    await File(tempPath).writeAsBytes(bytes);

    final result = await saveImage(tempPath, albumName: albumName);

    await tempDir.delete(recursive: true);
    return result;
  }

  Future<void> openGallery() async {
    await Gal.open();
  }

  Future<void> dispose() async {}
}
