import '../models/comment_models.dart';

List<CommentVM> generateMockComments() => [
      CommentVM(
        id: 'c1', userId: 'u1', userName: 'Ahmed K.',
        text: 'هذا المنتج رائع جداً! جودة ممتازة 🔥 استخدمته أسبوع وما خذلني',
        date: DateTime.now().subtract(const Duration(hours: 2)),
        likes: 24, reposts: 5,
        replies: [
          CommentVM(
            id: 'c1r1', userId: 'u2', userName: 'Sara M.',
            text: 'أوافقك الرأي تماماً، أفضل منتج جربته 👍',
            date: DateTime.now().subtract(const Duration(hours: 1)),
            likes: 8,
          ),
          CommentVM(
            id: 'c1r2', userId: 'u3', userName: 'Lina R.',
            text: 'هل يأتي بألوان أخرى؟',
            date: DateTime.now().subtract(const Duration(minutes: 30)),
            likes: 2,
          ),
        ],
      ),
      CommentVM(
        id: 'c2', userId: 'me', userName: 'You',
        text: 'سعر ممتاز بصراحة! 💯',
        date: DateTime.now().subtract(const Duration(hours: 5)),
        likes: 11, reposts: 2,
        isOwn: true,
        media: [
          CommentMedia(
              type: _MediaType.audio,
              path: 'voice_1.aac',
              audioDuration: const Duration(seconds: 15)),
        ],
      ),
      CommentVM(
        id: 'c3', userId: 'u4', userName: 'Omar T.',
        text: 'شاهد مراجعتي على الفيديو أدناه 👇',
        date: DateTime.now().subtract(const Duration(days: 1)),
        likes: 33, reposts: 12,
        media: [
          CommentMedia(type: _MediaType.video, path: 'review_video.mp4'),
          CommentMedia(type: _MediaType.image, path: 'img1.jpg'),
        ],
      ),
    ];
