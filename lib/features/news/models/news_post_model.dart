Enter// lib/features/news/models/news_post_model.dart

class NewsPostModel {
  final String id;
  final String userId;
  final String name;
  final String username;
  final String userAvatar;
  final String title;
  final String body;
  final int upvotes;
  final int comments;
  final int shares;
  final int views;
  final bool isUpvoted;
  final bool hasMedia;
  final bool isBookmarked;
  final bool isFollowing;
  final List<String> mediaUrls;
  final String mediaType;
  final DateTime createdAt;

  NewsPostModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.username,
    required this.userAvatar,
    required this.title,
    required this.body,
    this.upvotes = 0,
    this.comments = 0,
    this.shares = 0,
    this.views = 0,
    this.isUpvoted = false,
    this.hasMedia = false,
    this.isBookmarked = false,
    this.isFollowing = false,
    this.mediaUrls = const [],
    this.mediaType = 'image',
    required this.createdAt,
  });

  NewsPostModel copyWith({
    String? id, String? userId, String? name, String? username,
    String? userAvatar, String? title, String? body,
    int? upvotes, int? comments, int? shares, int? views,
    bool? isUpvoted, bool? hasMedia, bool? isBookmarked, bool? isFollowing,
    List<String>? mediaUrls, String? mediaType, DateTime? createdAt,
  }) {
    return NewsPostModel(
      id: id ?? this.id, userId: userId ?? this.userId,
      name: name ?? this.name, username: username ?? this.username,
      userAvatar: userAvatar ?? this.userAvatar,
      title: title ?? this.title, body: body ?? this.body,
      upvotes: upvotes ?? this.upvotes, comments: comments ?? this.comments,
      shares: shares ?? this.shares, views: views ?? this.views,
      isUpvoted: isUpvoted ?? this.isUpvoted, hasMedia: hasMedia ?? this.hasMedia,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isFollowing: isFollowing ?? this.isFollowing,
      mediaUrls: mediaUrls ?? this.mediaUrls, mediaType: mediaType ?? this.mediaType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static List<NewsPostModel> getMockPosts() => [
    NewsPostModel(id: '1', userId: 'user1', name: 'Ahmed Codes', username: '@ahmed_codes',
      userAvatar: '👨‍💻', title: 'Flutter 3.29 is amazing!',
      body: 'Just updated to Flutter 3.29 and the performance improvements are insane. Startup time dropped by 40% on my app.',
      upvotes: 12400, comments: 340, shares: 1200, views: 45000,
      createdAt: DateTime.now().subtract(const Duration(hours: 2))),
    NewsPostModel(id: '2', userId: 'user2', name: 'Sara Design', username: '@sara_ui',
      userAvatar: '👩‍🎨', title: 'Glassmorphism in 2025 🔥',
      body: 'Glassmorphism is still trending and honestly it looks incredible on dark backgrounds.',
      upvotes: 8900, comments: 210, shares: 890, views: 32000,
      isUpvoted: true, isBookmarked: true, isFollowing: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 5))),
    NewsPostModel(id: '3', userId: 'user3', name: 'Karim Dev', username: '@karim_dz',
      userAvatar: '🧑‍🚀', title: 'من الجزائر للعالم 🇩🇿',
      body: 'أطلقت تطبيقي الأول على Google Play وحصل على 1000 تحميل في اليوم الأول.',
      upvotes: 24300, comments: 780, shares: 3400, views: 89000,
      createdAt: DateTime.now().subtract(const Duration(hours: 1))),
    NewsPostModel(id: '4', userId: 'user4', name: 'Lina Tech', username: '@lina_codes',
      userAvatar: '👩‍💻', title: 'Riverpod vs BLoC in 2025',
      body: 'After using both for 2 years:\n• Riverpod: simpler, less boilerplate\n• BLoC: better for large teams',
      upvotes: 5600, comments: 430, shares: 670, views: 21000, isFollowing: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 8))),
    NewsPostModel(id: '5', userId: 'user5', name: 'Nour Startup', username: '@nour_build',
      userAvatar: '🎬', title: 'Lessons after 3 failed startups',
      body: '1. Build for a real problem\n2. Talk to users first\n3. Launch ugly and iterate\n4. Revenue > Downloads',
      upvotes: 18700, comments: 920, shares: 4500, views: 102000,
      createdAt: DateTime.now().subtract(const Duration(hours: 12))),
  ];
}
