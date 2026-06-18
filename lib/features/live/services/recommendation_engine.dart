import '../models/live_room_model.dart';
import '../data/mock_live_rooms.dart';

class RecommendationEngine {
  // خوارزمية توصية بسيطة بناءً على الاهتمامات وسجل المشاهدة
  Future<List<LiveRoomModel>> getRecommended({
    required List<String> interests,
    required List<String> viewedHostIds,
    required List<String> likedCategories,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var rooms = mockLiveRooms.where((r) => r.isLive).toList();

    // إعطاء أولوية للغرف التي تطابق الاهتمامات
    rooms.sort((a, b) {
      int aScore = 0, bScore = 0;

      // تطابق الفئة
      if (a.category != null && likedCategories.contains(a.category)) aScore += 3;
      if (b.category != null && likedCategories.contains(b.category)) bScore += 3;

      // مضيف جديد (غير مشاهد سابقًا)
      if (!viewedHostIds.contains(a.hostId)) aScore += 2;
      if (!viewedHostIds.contains(b.hostId)) bScore += 2;

      // عدد المشاهدين (شعبية)
      aScore += a.viewerCount > 100 ? 1 : 0;
      bScore += b.viewerCount > 100 ? 1 : 0;

      return bScore - aScore;
    });

    return rooms.take(10).toList();
  }
}
