import '../models/hotspot_model.dart';

final List<HotspotModel> mockHotspots = [
  HotspotModel(id: 'h1', name: 'منطقة الأكل', lat: 36.7525, lng: 3.0520, radius: 500, category: HotspotCategory.food, activityCount: 230, isTrending: true),
  HotspotModel(id: 'h2', name: 'منطقة الموسيقى', lat: 36.7580, lng: 3.0600, radius: 400, category: HotspotCategory.music, activityCount: 120),
];
