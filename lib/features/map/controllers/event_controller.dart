import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/event_service.dart';

class EventController extends ChangeNotifier {
  final EventService _service = EventService();
  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  Future<void> load() async {
    _events = await _service.fetchEvents();
    notifyListeners();
  }
}
