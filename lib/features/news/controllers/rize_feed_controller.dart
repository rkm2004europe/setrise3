import 'package:flutter/material.dart';
import '../models/rize_post_model.dart';
import '../services/rize_feed_service.dart';

class RizeFeedController extends ChangeNotifier {
  final RizeFeedService _service = RizeFeedService();

  List<RizePostModel> _posts = [];
  bool _isLoading = false;

  List<RizePostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchFeed() async {
    _isLoading = true;
    notifyListeners();

    _posts = await _service.fetchFeed();

    _isLoading = false;
    notifyListeners();
  }

  void updatePost(int index, RizePostModel updatedPost) {
    _posts[index] = updatedPost;
    notifyListeners();
  }
}
