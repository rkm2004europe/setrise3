import 'package:flutter/material.dart';
import '../models/live_comment_model.dart';

class ChatLiveController extends ChangeNotifier {
  final List<LiveCommentModel> _comments = [];
  List<LiveCommentModel> get comments => _comments;

  void addComment(LiveCommentModel comment) {
    _comments.insert(0, comment);
    notifyListeners();
  }
}
