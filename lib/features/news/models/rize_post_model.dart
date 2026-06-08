enum RizeMediaType { image, video, audio }

class RizePostModel {
  final String id;
  final String userId;
  final String userName;
  final String username;
  final String? userAvatar;
  final String text; // أقصى 250 حرف
  final List<String> mediaUrls;
  final RizeMediaType? mediaType;
  final DateTime createdAt;
  int likes;
  int comments;
  int shares;
  bool isLiked;
  bool isBookmarked;
  bool isFollowing;

  RizePostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.username,
    this.userAvatar,
    required this.text,
    this.mediaUrls = const [],
    this.mediaType,
    DateTime? createdAt,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isLiked = false,
    this.isBookmarked = false,
    this.isFollowing = false,
  }) : createdAt = createdAt ?? DateTime.now();

  RizePostModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? username,
    String? userAvatar,
    String? text,
    List<String>? mediaUrls,
    RizeMediaType? mediaType,
    DateTime? createdAt,
    int? likes,
    int? comments,
    int? shares,
    bool? isLiked,
    bool? isBookmarked,
    bool? isFollowing,
  }) {
    return RizePostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      username: username ?? this.username,
      userAvatar: userAvatar ?? this.userAvatar,
      text: text ?? this.text,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      mediaType: mediaType ?? this.mediaType,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}
