import 'package:flutter/material.dart';

class PostFilter {
  final String name;
  final Color? colorOverlay;
  final double brightness;
  final double contrast;
  final double saturation;
  final double exposure;

  const PostFilter({
    required this.name,
    this.colorOverlay,
    this.brightness = 0,
    this.contrast = 1,
    this.saturation = 1,
    this.exposure = 0,
  });
}

const List<PostFilter> availableFilters = [
  PostFilter(name: 'Original'),
  PostFilter(name: 'Clarendon', brightness: 0.1, contrast: 1.1, saturation: 1.2),
  PostFilter(name: 'Lark', brightness: 0.15, saturation: 1.3, exposure: 0.1),
  PostFilter(name: 'Juno', saturation: 1.4, contrast: 1.05),
  PostFilter(name: 'Ludwig', brightness: 0.05, contrast: 1.15),
  PostFilter(name: 'Aden', brightness: 0.1, saturation: 0.9, contrast: 1.1),
  PostFilter(name: 'Perpetua', brightness: 0.2, saturation: 0.8),
  PostFilter(name: 'Amaro', brightness: 0.15, saturation: 1.1, exposure: 0.1),
  PostFilter(name: 'Mayfair', brightness: 0.1, saturation: 1.2, contrast: 1.1),
  PostFilter(name: 'Rise', brightness: 0.2, saturation: 1.0, exposure: 0.15),
  PostFilter(name: 'Valencia', brightness: 0.1, contrast: 1.05, saturation: 1.1),
  PostFilter(name: 'X-Pro II', contrast: 1.3, saturation: 1.2),
  PostFilter(name: 'Sierra', brightness: 0.1, contrast: 0.9, saturation: 1.2),
  PostFilter(name: 'Willow', brightness: 0.05, saturation: 0.8),
  PostFilter(name: 'Lo-Fi', contrast: 1.2, saturation: 1.3),
  PostFilter(name: 'Earlybird', brightness: 0.1, saturation: 0.9, contrast: 1.1),
  PostFilter(name: 'Brannan', contrast: 1.2, saturation: 0.9, brightness: 0.05),
  PostFilter(name: 'Inkwell', saturation: 0, contrast: 1.2),
  PostFilter(name: 'Hefe', contrast: 1.1, saturation: 1.2, brightness: 0.05),
  PostFilter(name: 'Nashville', brightness: 0.15, saturation: 0.9, contrast: 1.0),
];
