import 'package:flutter/material.dart';
import '../models/group_model.dart';

class GroupController extends ChangeNotifier {
  GroupModel? _group;
  GroupModel? get group => _group;

  void load(GroupModel g) { _group = g; notifyListeners(); }

  void addMember(GroupMember m) {
    _group?.members.add(m);
    notifyListeners();
  }

  void removeMember(String userId) {
    _group?.members.removeWhere((m) => m.userId == userId);
    notifyListeners();
  }

  void changeRole(String userId, MemberRole role) {
    final idx = _group?.members.indexWhere((m) => m.userId == userId);
    if (idx != null && idx != -1) {
      _group!.members[idx].role = role;
      notifyListeners();
    }
  }
}
