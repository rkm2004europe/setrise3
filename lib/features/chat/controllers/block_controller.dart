import 'package:flutter/material.dart';
import '../models/models.dart';
import '../data/mock_blocked.dart';

class BlockController extends ChangeNotifier {
  final List<User> _blocked = List.from(mockBlockedUsers);

  List<User> get blocked => _blocked;

  void block(User user) {
    _blocked.add(user);
    notifyListeners();
  }

  void unblock(String userId) {
    _blocked.removeWhere((u) => u.id == userId);
    notifyListeners();
  }

  bool isBlocked(String userId) => _blocked.any((u) => u.id == userId);
}
