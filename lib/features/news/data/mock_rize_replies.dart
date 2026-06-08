import '../models/rize_reply_model.dart';

List<RizeReplyModel> mockReplies = [
  RizeReplyModel(
    id: 'r1',
    userId: 'u2',
    userName: 'Sara M.',
    username: '@sara_m',
    text: 'أوافقك الرأي تمامًا!',
    likes: 12,
    replies: [
      RizeReplyModel(
        id: 'r1_1',
        userId: 'u3',
        userName: 'Omar T.',
        username: '@omar_t',
        text: 'نعم، هذه أفضل طريقة للتعلم.',
        likes: 5,
        isLiked: true,
      ),
    ],
  ),
  RizeReplyModel(
    id: 'r2',
    userId: 'u4',
    userName: 'Lina R.',
    username: '@lina_r',
    text: 'تحديث رائع! متى الإطلاق؟',
    likes: 8,
  ),
];
