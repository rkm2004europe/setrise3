import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../services/radio_service.dart';

class RadioController extends ChangeNotifier {
  final RadioService _service = RadioService();
  List<String> _stations = [];
  List<String> get stations => _stations;

  Future<void> loadStations() async { _stations = await _service.getStations(); notifyListeners(); }
}
