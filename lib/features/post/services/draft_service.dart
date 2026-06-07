import '../models/draft_model.dart';

class DraftService {
  final List<DraftModel> _drafts = [];

  Future<void> saveDraft(DraftModel draft) async {
    _drafts.add(draft);
    // TODO: store locally using shared_preferences or hive
  }

  List<DraftModel> get drafts => _drafts;

  Future<void> deleteDraft(String id) async {
    _drafts.removeWhere((d) => d.id == id);
  }
}
