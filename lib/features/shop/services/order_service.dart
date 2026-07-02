// lib/features/shop/services/order_service.dart

import '../models/order_model.dart';
import '../data/mock_orders.dart';

class OrderService {
  Future<List<OrderModel>> fetchOrders() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockOrders;
  }

  Future<void> cancelOrder(String orderId) async {
    await Future.delayed(const Duration(seconds: 1));
    mockOrders.removeWhere((o) => o.id == orderId);
  }
}
