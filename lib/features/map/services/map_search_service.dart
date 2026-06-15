import '../models/place_model.dart';
import '../data/mock_places.dart';

class MapSearchService {
  Future<List<PlaceModel>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (query.isEmpty) return [];
    return mockPlaces
        .where((p) =>
            p.name.toLowerCase().contains(query.toLowerCase()) ||
            p.type.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
