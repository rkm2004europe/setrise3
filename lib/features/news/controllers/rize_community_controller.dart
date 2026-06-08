import 'package:flutter/material.dart';
import '../models/rize_community_model.dart';
import '../services/rize_community_service.dart';

class RizeCommunityController extends ChangeNotifier {
  final RizeCommunityService _service = RizeCommunityService();
  List<RizeCommunityModel> _communities = [];
  bool _isLoading = false;

  List<RizeCommunityModel> get communities => _communities;
  bool get isLoading => _isLoading;

  Future<void> fetchCommunities() async {
    _isLoading = true;
    notifyListeners();
    _communities = await _service.fetchCommunities();
    _isLoading = false;
    notifyListeners();
  }
}
