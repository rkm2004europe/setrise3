import '../models/order_model.dart';

final List<OrderModel> mockOrders = [
  OrderModel(id: 'o1', productId: 'p1', productName: 'هاتف ذكي Pro Max', amount: 1200, status: OrderStatus.shipped, createdAt: DateTime.now().subtract(const Duration(days: 3)), trackingNumber: 'TRK12345'),
  OrderModel(id: 'o2', productId: 'p2', productName: 'حذاء رياضي نايك', amount: 350, status: OrderStatus.delivered, createdAt: DateTime.now().subtract(const Duration(days: 7))),
];
