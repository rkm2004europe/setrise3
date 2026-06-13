import 'package:flutter/material.dart';
import '../models/date_user_model.dart';
import '../models/date_match_model.dart';

class DateMatchController extends ChangeNotifier {
  final List<DateMatchModel> _matches = [];

  List<DateMatchModel> get matches => _matches;

  DateMatchModel? checkMatch(DateUserModel currentUser, DateUserModel likedUser) {
    // محاكاة تطابق عشوائي
    final isMatch = DateTime.now().millisecond % 2 == 0;
    if (isMatch) {
      final match = DateMatchModel(
        id: 'match_${DateTime.now().millisecondsSinceEpoch}',
        userId: currentUser.id,
        matchedUserId: likedUser.id,
        matchedAt: DateTime.now(),
      );
      _matches.add(match);
      notifyListeners();
      return match;
    }
    return null;
  }
}
