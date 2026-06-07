import 'package:flutter/material.dart';
import 'dart:async';

/// يتحكم بحالة التحرير (سيُستخدم لاحقًا مع Provider أو Riverpod)
class EditorController extends ChangeNotifier {
  String? _mediaPath;
  bool _isVideo = false;
  int _selectedFilterIndex = 0;
  double _filterIntensity = 1.0;
  String? _selectedMusicTrack;
  String? _taggedProduct;
  String? _selectedLocation;
  String? _mentionedUser;

  // Getters
  String? get mediaPath => _mediaPath;
  bool get isVideo => _isVideo;
  int get selectedFilterIndex => _selectedFilterIndex;
  double get filterIntensity => _filterIntensity;
  String? get selectedMusicTrack => _selectedMusicTrack;
  String? get taggedProduct => _taggedProduct;
  String? get selectedLocation => _selectedLocation;
  String? get mentionedUser => _mentionedUser;

  void setMedia(String path, bool isVideo) {
    _mediaPath = path;
    _isVideo = isVideo;
    notifyListeners();
  }

  void setFilter(int index, {double? intensity}) {
    _selectedFilterIndex = index;
    if (intensity != null) _filterIntensity = intensity;
    notifyListeners();
  }

  void setMusicTrack(String? track) {
    _selectedMusicTrack = track;
    notifyListeners();
  }

  void setProduct(String? product) {
    _taggedProduct = product;
    notifyListeners();
  }

  void setLocation(String? location) {
    _selectedLocation = location;
    notifyListeners();
  }

  void setMention(String? username) {
    _mentionedUser = username;
    notifyListeners();
  }

  void reset() {
    _mediaPath = null;
    _isVideo = false;
    _selectedFilterIndex = 0;
    _filterIntensity = 1.0;
    _selectedMusicTrack = null;
    _taggedProduct = null;
    _selectedLocation = null;
    _mentionedUser = null;
    notifyListeners();
  }
}
