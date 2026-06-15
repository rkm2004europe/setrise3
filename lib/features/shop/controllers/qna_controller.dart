import 'package:flutter/material.dart';
import '../models/qna_model.dart';
import '../services/qna_service.dart';
class QnaController extends ChangeNotifier {
  final QnaService _service = QnaService();
  List<QnaModel> _items = [];
  List<QnaModel> get items => _items;
  Future<void> load(String productId) async { _items = await _service.fetchQna(productId); notifyListeners(); }
}
