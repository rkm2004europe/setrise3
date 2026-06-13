import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/chat_service.dart';

class SearchController extends ChangeNotifier {
  final ChatService _service = ChatService();
  List<Conversation> _results = [];
  List<Conversation> get results => _results;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      _results = [];
    } else {
      // محاكاة
      _results = await _service.fetchInbox();
      _results = _results.where((c) => c.displayName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}
