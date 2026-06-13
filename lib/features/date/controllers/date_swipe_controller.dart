import 'package:flutter/material.dart';
import '../models/date_user_model.dart';

class DateSwipeController extends ChangeNotifier {
  final List<DateUserModel> _liked = [];
  final List<DateUserModel> _passed = [];

  List<DateUserModel> get liked => _liked;

  void like(DateUserModel user) {
    _liked.add(user);
    notifyListeners();
  }

  void pass(DateUserModel user) {
    _passed.add(user);
    notifyListeners();
  }
}
