import 'package:flutter/material.dart';

class TemplateModel {
  final String id;
  final String name;
  final String captionPlaceholder;
  final String hashtags;
  final Color color;

  const TemplateModel({
    required this.id,
    required this.name,
    required this.captionPlaceholder,
    required this.hashtags,
    required this.color,
  });
}
