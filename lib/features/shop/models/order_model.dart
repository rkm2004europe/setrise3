enum OrderStatus { pending, confirmed, shipped, delivered, cancelled }

class OrderModel {
  final String id;
  final String productId;
  final String productName;
  final double amount;
  final OrderStatus status;
  final DateTime createdAt;
  final String? trackingNumber;

  OrderModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.trackingNumber,
  });
}
