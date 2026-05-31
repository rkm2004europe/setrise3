// lib/features/comment/models/comment_model.dart

enum CommentContextType { product, live, post, reel, general }
enum MediaType { image, video, audio }

class CommentMedia {
  final MediaType type;
  final String path;
  final Duration? audioDuration;
  const CommentMedia({required this.type, required this.path, this.audioDuration});
}

class CommentModel {
  final String id;
  final String userId;
  final String userName;
  final String username;
  final String? avatarUrl;
  final String bio;
  final int followers;
  final int following;
  final int postsCount;
  final bool isVerified;
  final bool isFollowing;
  final String? text;
  final List<CommentMedia> media;
  final DateTime date;
  int likes;
  int reposts;
  bool liked;
  bool reposted;
  bool isOwn;
  List<CommentModel> replies;
  bool isDeleted;

  CommentModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.username = '',
    this.avatarUrl,
    this.bio = '',
    this.followers = 0,
    this.following = 0,
    this.postsCount = 0,
    this.isVerified = false,
    this.isFollowing = false,
    this.text,
    this.media = const [],
    DateTime? date,
    this.likes = 0,
    this.reposts = 0,
    this.liked = false,
    this.reposted = false,
    this.isOwn = false,
    List<CommentModel>? replies,
    this.isDeleted = false,
  })  : date = date ?? DateTime.now(),
        replies = replies ?? [];
}
