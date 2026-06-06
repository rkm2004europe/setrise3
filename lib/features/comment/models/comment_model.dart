import 'package:flutter/material.dart';

enum CommentContextType { product, live, post, reel, general }

enum _MediaType { image, video, audio }

class CommentMedia {
  final _MediaType type;
  final String path;
  final Duration? audioDuration;
  const CommentMedia({required this.type, required this.path, this.audioDuration});
}

class CommentVM {
  final String id;
  final String userId;
  final String userName;
  final String username; // @username
  final String? avatarUrl;
  final String? text;
  final List<CommentMedia> media;
  final DateTime date;
  int likes;
  int upvotes;
  int repliesCount; // لسهولة العرض
  bool liked;
  bool upvoted;
  bool saved;
  bool reposted;
  bool isOwn;
  List<CommentVM> replies;
  bool isDeleted;

  CommentVM({
    required this.id,
    required this.userId,
    required this.userName,
    this.username = '',
    this.avatarUrl,
    this.text,
    this.media = const [],
    DateTime? date,
    this.likes = 0,
    this.upvotes = 0,
    this.repliesCount = 0,
    this.liked = false,
    this.upvoted = false,
    this.saved = false,
    this.reposted = false,
    this.isOwn = false,
    List<CommentVM>? replies,
    this.isDeleted = false,
  })  : date = date ?? DateTime.now(),
        replies = replies ?? [];
}
