import 'package:flutter/material.dart';
import '../services/gift_card_service.dart';
class GiftCardController extends ChangeNotifier {
  final GiftCardService _service = GiftCardService();
  Future<void> purchase(double amount, String email) async => await _service.purchase(amount, email);
}
