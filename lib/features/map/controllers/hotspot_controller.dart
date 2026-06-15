import 'package:flutter/material.dart';
import '../models/hotspot_model.dart';
import '../services/hotspot_service.dart';

class HotspotController extends ChangeNotifier {
  final HotspotService _service = HotspotService();
  List<HotspotModel> _hotspots = [];
  List<HotspotModel> get hotspots => _hotspots;

  Future<void> load() async {
    _hotspots = await _service.fetchHotspots();
    notifyListeners();
  }
}
