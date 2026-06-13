import '../models/date_match_model.dart';

class DateMatchService {
  final List<DateMatchModel> _matches = [];

  Future<void> createMatch(String userId, String matchedUserId) async {
    await Future.delayed(const Duration(seconds: 1));
    _matches.add(DateMatchModel(id: 'match_${DateTime.now().millisecondsSinceEpoch}', userId: userId, matchedUserId: matchedUserId, matchedAt: DateTime.now()));
  }

  List<DateMatchModel> getMatches(String userId) => _matches.where((m) => m.userId == userId || m.matchedUserId == userId).toList();
}
