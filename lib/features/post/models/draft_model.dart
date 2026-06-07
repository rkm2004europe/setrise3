import 'package:flutter/material.dart';

class DraftModel {
  final String id;
  final String? mediaPath;
  final String? caption;
  final String? hashtags;
  final String? musicTrackId;
  final String? productId;
  final String? location;
  final DateTime savedAt;
  final Map<String, dynamic>? filterSettings;

  const DraftModel({
    required this.id,
    this.mediaPath,
    this.caption,
    this.hashtags,
    this.musicTrackId,
    this.productId,
    this.location,
    required this.savedAt,
    this.filterSettings,
  });
}
