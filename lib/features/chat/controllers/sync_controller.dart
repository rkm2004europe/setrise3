import 'package:flutter/material.dart';
import '../services/sync_service.dart';

class SyncController extends ChangeNotifier {
  final SyncService _service = SyncService();
  bool _syncing = false;
  bool get syncing => _syncing;

  Future<void> sync() async {
    _syncing = true;
    notifyListeners();
    await _service.syncNow();
    _syncing = false;
    notifyListeners();
  }
}
