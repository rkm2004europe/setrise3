import 'package:flutter/material.dart';
import '../models/live_room_model.dart';
import '../models/live_comment_model.dart';

class LiveRoomController extends ChangeNotifier {
  LiveRoomModel? _room;
  List<LiveCommentModel> _comments = [];
  int _viewerCount = 0;
  int _giftTotal = 0;

  LiveRoomModel? get room => _room;
  List<LiveCommentModel> get comments => _comments;
  int get viewerCount => _viewerCount;
  int get giftTotal => _giftTotal;

  void setRoom(LiveRoomModel room) { _room = room; notifyListeners(); }
  void addComment(LiveCommentModel comment) { _comments.insert(0, comment); notifyListeners(); }
  void incrementViewers() { _viewerCount++; notifyListeners(); }
  void addGift(int coins) { _giftTotal += coins; notifyListeners(); }
}
