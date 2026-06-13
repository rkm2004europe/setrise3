import 'package:flutter/material.dart';
import '../models/date_user_model.dart';

class BlindDateController extends ChangeNotifier {
  final List<DateUserModel> _liked = [];

  List<DateUserModel> get liked => _liked;

  void like(DateUserModel user) {
    _liked.add(user);
    notifyListeners();
  }

  bool isMatch(String userId1, String userId2) {
    // محاكاة بسيطة
    return DateTime.now().millisecond % 2 == 0;
  }
}
