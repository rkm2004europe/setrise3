import 'package:flutter/material.dart';
import '../services/rize_repost_service.dart';

class RizeRepostController extends ChangeNotifier {
  final RizeRepostService _service = RizeRepostService();
  bool _isReposting = false;
  bool get isReposting => _isReposting;

  Future<void> repost(String postId, String comment) async {
    _isReposting = true;
    notifyListeners();
    await _service.repost(postId, comment);
    _isReposting = false;
    notifyListeners();
  }
}
