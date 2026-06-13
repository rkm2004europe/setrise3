class DeliveryService {
  Future<String> requestDelivery(String orderId) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'TRACK-${DateTime.now().millisecondsSinceEpoch}';
  }
}
