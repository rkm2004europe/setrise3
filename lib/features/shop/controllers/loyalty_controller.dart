import 'package:flutter/material.dart';
import '../models/loyalty_model.dart';
import '../services/loyalty_service.dart';
class LoyaltyController extends ChangeNotifier {
  final LoyaltyService _service = LoyaltyService();
  late LoyaltyModel _model = _service.get();
  LoyaltyModel get model => _model;
}
