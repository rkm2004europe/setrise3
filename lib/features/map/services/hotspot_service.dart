import '../models/hotspot_model.dart';
import '../data/mock_hotspots.dart';

class HotspotService {
  Future<List<HotspotModel>> fetchHotspots() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockHotspots;
  }
}
