import 'package:flutter/material.dart';
import '../models/draft_model.dart';

class DraftController extends ChangeNotifier {
  final Map<String, DraftModel> _drafts = {};

  DraftModel? getDraft(String convId) => _drafts[convId];

  void saveDraft(String convId, String text) {
    _drafts[convId] = DraftModel(conversationId: convId, text: text, savedAt: DateTime.now());
    notifyListeners();
  }

  void clearDraft(String convId) {
    _drafts.remove(convId);
    notifyListeners();
  }
}
