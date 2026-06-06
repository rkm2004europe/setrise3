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
  final String? avatarUrl;
  final String? text;
  final List<CommentMedia> media;
  final DateTime date;
  int likes;
  int reposts;
  bool liked;
  bool reposted;
  bool isOwn;
  List<CommentVM> replies;
  bool isDeleted;

  CommentVM({
    required this.id,
    required this.userId,
    required this.userName,
    this.avatarUrl,
    this.text,
    this.media = const [],
    DateTime? date,
    this.likes = 0,
    this.reposts = 0,
    this.liked = false,
    this.reposted = false,
    this.isOwn = false,
    List<CommentVM>? replies,
    this.isDeleted = false,
  })  : date = date ?? DateTime.now(),
        replies = replies ?? [];
}
