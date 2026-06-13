class PaymentService {
  Future<bool> processPayment({required String method, required double amount}) async {
    await Future.delayed(const Duration(seconds: 2));
    return true; // نجاح
  }
}
