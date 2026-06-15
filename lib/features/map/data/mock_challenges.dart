import '../models/challenge_model.dart';

final List<ChallengeModel> mockChallenges = [
  ChallengeModel(
    id: 'c1', title: 'تحدي الأكل الحار', description: 'تناول طبق حار وشارك فيديو', lat: 36.7520, lng: 3.0540,
    reward: 500, startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(hours: 5)), participantsCount: 34,
  ),
  ChallengeModel(
    id: 'c2', title: 'تحدي الـ 10,000 خطوة', description: 'امشِ 10 آلاف خطوة واربح', lat: 36.7600, lng: 3.0620,
    reward: 300, startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(hours: 12)), participantsCount: 12,
  ),
];
