library;

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

import '../entities/media_source.dart';
import '../utils/typedefs.dart';

class MediaPickerService {
  MediaPickerService();

  Future<void> initialize() async {
    await PhotoManager.setIgnorePermissionCheck(false);
    final perm = await PhotoManager.requestPermissionExtend();
    if (!perm.hasAccess) {
      throw StateError('Photo library access denied');
    }
  }

  Future<List<MediaSourceFile>> convertAssetsToSources(
    List<AssetEntity> assets,
  ) async {
    final results = <MediaSourceFile>[];
    for (final asset in assets) {
      final file = await asset.loadFile();
      if (file == null) continue;
      final source = await _inspect(file, asset);
      results.add(source);
    }
    return results;
  }

  Future<MediaSourceFile> _inspect(File file, AssetEntity asset) async {
    final path = file.path;
    final mime = asset.mimeType ?? _guessMime(path);
    int width = asset.width;
    int height = asset.height;
    Microseconds duration = asset.duration.inMicroseconds;
    int sizeBytes = await file.length();

    return MediaSourceFile(
      id: const Uuid().v4(),
      path: path,
      mimeType: mime,
      duration: duration,
      width: width,
      height: height,
      sizeBytes: sizeBytes,
      createdAt: asset.createDateTime,
    );
  }

  Future<MediaSourceFile> sourceFromFile(File file) async {
    final mime = _guessMime(file.path);
    int width = 0;
    int height = 0;
    Microseconds duration = 0;

    if (mime.startsWith('video/')) {
      width = 1080;
      height = 1920;
      duration = 5 * 1000000;
    } else if (mime.startsWith('image/')) {
      width = 1080;
      height = 1920;
    }

    return MediaSourceFile(
      id: const Uuid().v4(),
      path: file.path,
      mimeType: mime,
      duration: duration,
      width: width,
      height: height,
      sizeBytes: await file.length(),
      createdAt: DateTime.now(),
    );
  }

  String _guessMime(String path) {
    final ext = p.extension(path).toLowerCase();
    return switch (ext) {
      '.mp4' => 'video/mp4',
      '.mov' => 'video/quicktime',
      '.m4a' => 'audio/m4a',
      '.aac' => 'audio/aac',
      '.mp3' => 'audio/mpeg',
      '.wav' => 'audio/wav',
      '.jpg' || '.jpeg' => 'image/jpeg',
      '.png' => 'image/png',
      '.gif' => 'image/gif',
      '.webp' => 'image/webp',
      _ => 'application/octet-stream',
    };
  }

  Future<String?> generateThumbnail(File file, {int quality = 80}) async {
    return null;
  }

  Future<void> dispose() async {}
}
