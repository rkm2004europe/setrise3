// lib/features/shop/controllers/gift_card_controller.dart
//
// متحكم بطاقات الهدايا — Singleton + ChangeNotifier
//
// الإصلاحات:
//   - تحويل إلى Singleton
//   - إضافة حالة (isLoading, error, lastPurchasedCode, purchasedCards)
//   - استدعاء notifyListeners() بعد كل عملية
//   - إرجاع كود البطاقة المُشتراة

import 'package:flutter/material.dart';
import '../services/gift_card_service.dart';

class GiftCardController extends ChangeNotifier {
  static final GiftCardController _instance = GiftCardController._();
  factory GiftCardController() => _instance;
  GiftCardController._();

  final GiftCardService _service = GiftCardService();

  bool _isLoading = false;
  String? _error;
  String? _lastPurchasedCode;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get lastPurchasedCode => _lastPurchasedCode;
  List<double> get availableValues => _service.availableValues;
  List get purchasedCards => _service.purchasedCards;
  double get totalPurchased => _service.totalPurchased;

  /// شراء بطاقة هدية. يُرجِع كود البطاقة عند النجاح.
  Future<String?> purchase(double amount, String email) async {
    _isLoading = true;
    _error = null;
    _lastPurchasedCode = null;
    notifyListeners();
    try {
      _lastPurchasedCode = await _service.purchase(amount, email);
    } catch (e) {
      _error = 'فشل شراء البطاقة: ${e.toString()}';
      debugPrint('GiftCardController.purchase error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return _lastPurchasedCode;
  }
}
