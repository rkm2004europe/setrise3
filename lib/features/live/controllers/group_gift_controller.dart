import 'package:flutter/material.dart';
import '../models/group_gift_model.dart';

class GroupGiftController extends ChangeNotifier {
  GroupGiftModel? _currentGift;

  void startGroupGift(GroupGiftModel gift) { _currentGift = gift; notifyListeners(); }
  void contribute() {
    if (_currentGift != null && !_currentGift!.isCompleted) {
      _currentGift!.currentContributors++;
      if (_currentGift!.currentContributors >= _currentGift!.requiredContributors) {
        _currentGift!.isCompleted = true;
      }
      notifyListeners();
    }
  }
}
