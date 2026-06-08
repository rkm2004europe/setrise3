import 'package:flutter/material.dart';
import '../models/rize_list_model.dart';
import '../services/rize_list_service.dart';

class RizeListController extends ChangeNotifier {
  final RizeListService _service = RizeListService();
  List<RizeListModel> _lists = [];
  bool _isLoading = false;

  List<RizeListModel> get lists => _lists;
  bool get isLoading => _isLoading;

  Future<void> fetchLists() async {
    _isLoading = true;
    notifyListeners();
    _lists = await _service.fetchLists();
    _isLoading = false;
    notifyListeners();
  }
}
