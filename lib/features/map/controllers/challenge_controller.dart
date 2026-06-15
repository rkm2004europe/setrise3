import 'package:flutter/material.dart';
import '../models/challenge_model.dart';
import '../services/challenge_service.dart';

class ChallengeController extends ChangeNotifier {
  final ChallengeService _service = ChallengeService();
  List<ChallengeModel> _challenges = [];
  List<ChallengeModel> get challenges => _challenges;

  Future<void> load() async {
    _challenges = await _service.fetchChallenges();
    notifyListeners();
  }
}
