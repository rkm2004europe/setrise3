import '../models/rize_list_model.dart';
import '../data/mock_rize_lists.dart';

class RizeListService {
  Future<List<RizeListModel>> fetchLists() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockLists;
  }
}
