import '../models/comment_models.dart';

List<CommentVM> generateMockComments() => [
      CommentVM(
        id: 'c1', userId: 'u1', userName: 'Ahmed K.', username: '@ahmed_k',
        text: 'هذا المنتج رائع جداً! جودة ممتازة 🔥',
        date: DateTime.now().subtract(const Duration(hours: 2)),
        likes: 24, upvotes: 15, repliesCount: 2,
        replies: [
          CommentVM(
            id: 'c1r1', userId: 'u2', userName: 'Sara M.', username: '@sara_m',
            text: 'أوافقك الرأي 👍', likes: 8, upvotes: 3,
          ),
          CommentVM(
            id: 'c1r2', userId: 'u3', userName: 'Lina R.', username: '@lina_r',
            text: 'هل يأتي بألوان أخرى؟', likes: 2,
          ),
        ],
      ),
      CommentVM(
        id: 'c2', userId: 'me', userName: 'You', username: '@you',
        text: 'سعر ممتاز بصراحة! 💯',
        likes: 11, upvotes: 7, isOwn: true,
        media: [
          CommentMedia(type: _MediaType.audio, path: 'voice_1.aac',
              audioDuration: const Duration(seconds: 15)),
        ],
      ),
      CommentVM(
        id: 'c3', userId: 'u4', userName: 'Omar T.', username: '@omar_t',
        text: 'شاهد مراجعتي على الفيديو 👇',
        likes: 33, upvotes: 22, reposted: true,
        media: [
          CommentMedia(type: _MediaType.video, path: 'review_video.mp4'),
          CommentMedia(type: _MediaType.image, path: 'img1.jpg'),
        ],
      ),
    ];
