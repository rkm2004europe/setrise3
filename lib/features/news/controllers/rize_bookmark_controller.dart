import 'package:flutter/material.dart';
import '../services/rize_bookmark_service.dart';

class RizeBookmarkController extends ChangeNotifier {
  final RizeBookmarkService _service = RizeBookmarkService();

  Future<void> toggle(String postId) async {
    await _service.toggleBookmark(postId);
    notifyListeners();
  }

  bool isBookmarked(String postId) => _service.isBookmarked(postId);
}
