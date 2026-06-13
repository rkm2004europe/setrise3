import 'package:flutter/material.dart';
import '../models/date_preferences_model.dart';

class DatePreferencesController extends ChangeNotifier {
  DatePreferencesModel _prefs = DatePreferencesModel();
  DatePreferencesModel get prefs => _prefs;

  void updateAge(int min, int max) { _prefs = DatePreferencesModel(minAge: min, maxAge: max, maxDistance: _prefs.maxDistance); notifyListeners(); }
  void updateDistance(double km) { _prefs = DatePreferencesModel(minAge: _prefs.minAge, maxAge: _prefs.maxAge, maxDistance: km.toInt()); notifyListeners(); }
  void setInterests(List<String> interests) { _prefs = DatePreferencesModel(minAge: _prefs.minAge, maxAge: _prefs.maxAge, maxDistance: _prefs.maxDistance, interests: interests); notifyListeners(); }
}
