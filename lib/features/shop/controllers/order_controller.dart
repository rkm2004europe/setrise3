import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../data/mock_orders.dart';

class OrderController extends ChangeNotifier {
  List<OrderModel> _orders = mockOrders;

  List<OrderModel> get orders => _orders;

  void cancelOrder(String orderId) {
    _orders.removeWhere((o) => o.id == orderId);
    notifyListeners();
  }
}
