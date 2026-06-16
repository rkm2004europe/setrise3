import 'package:flutter/material.dart';

class HostController extends ChangeNotifier {
  bool _isLive = false;
  int _viewers = 0, _gifts = 0;

  bool get isLive => _isLive;
  int get viewers => _viewers;
  int get gifts => _gifts;

  void startStream() { _isLive = true; notifyListeners(); }
  void endStream() { _isLive = false; notifyListeners(); }
  void addViewer() { _viewers++; notifyListeners(); }
  void addGift(int coins) { _gifts += coins; notifyListeners(); }
}
