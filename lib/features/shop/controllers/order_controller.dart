// lib/features/shop/controllers/order_controller.dart
//
// متحكم الطلبات — Singleton + ChangeNotifier
//
// الإصلاحات:
//   - تحويل إلى Singleton
//   - استخدام OrderService بدل الوصول المباشر لـ mockOrders
//   - إضافة loadOrders() و isLoading و error
//   - تحديث cancelOrder() لاستدعاء الخدمة

import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderController extends ChangeNotifier {
  static final OrderController _instance = OrderController._();
  factory OrderController() => _instance;
  OrderController._();

  final OrderService _service = OrderService();

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<OrderModel> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// تحميل الطلبات من الخدمة
  Future<void> loadOrders() async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _orders = await _service.fetchOrders();
    } catch (e) {
      _error = 'فشل تحميل الطلبات.';
      debugPrint('OrderController.loadOrders error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// إلغاء طلب
  Future<bool> cancelOrder(String orderId) async {
    try {
      await _service.cancelOrder(orderId);
      _orders.removeWhere((o) => o.id == orderId);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('OrderController.cancelOrder error: $e');
      return false;
    }
  }

  /// فلترة حسب الحالة
  List<OrderModel> byStatus(OrderStatus status) =>
      _orders.where((o) => o.status == status).toList();

  /// الطلبات النشطة (غير مُسلَّمة وغير ملغاة)
  List<OrderModel> get activeOrders => _orders
      .where((o) =>
          o.status != OrderStatus.delivered &&
          o.status != OrderStatus.cancelled)
      .toList();
}
