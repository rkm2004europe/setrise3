import 'package:flutter/material.dart';

class MapController extends ChangeNotifier {
  double _zoom = 14;
  double get zoom => _zoom;

  void updateZoom(double newZoom) { _zoom = newZoom; notifyListeners(); }
}
