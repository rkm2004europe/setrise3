import '../models/rize_community_model.dart';

const List<RizeCommunityModel> mockCommunities = [
  RizeCommunityModel(
    id: 'c1',
    name: 'Flutter Developers',
    description: 'مجتمع مطوري Flutter في العالم العربي',
    membersCount: 12500,
  ),
  RizeCommunityModel(
    id: 'c2',
    name: 'UI/UX Design',
    description: 'كل ما يتعلق بتصميم واجهات المستخدم',
    membersCount: 8300,
  ),
  RizeCommunityModel(
    id: 'c3',
    name: 'Startup Arabia',
    description: 'رواد أعمال وشركات ناشئة',
    membersCount: 15200,
    isJoined: true,
  ),
  RizeCommunityModel(
    id: 'c4',
    name: 'AI & ML',
    description: 'الذكاء الاصطناعي وتعلم الآلة',
    membersCount: 9700,
  ),
];
