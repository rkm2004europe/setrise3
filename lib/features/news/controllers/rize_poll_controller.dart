import 'package:flutter/material.dart';
import '../services/rize_poll_service.dart';

class RizePollController extends ChangeNotifier {
  final RizePollService _service = RizePollService();
  bool _isVoting = false;
  bool get isVoting => _isVoting;

  Future<void> vote(String pollId, int optionIndex) async {
    _isVoting = true;
    notifyListeners();
    await _service.vote(pollId, optionIndex);
    _isVoting = false;
    notifyListeners();
  }
}
