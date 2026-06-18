import 'package:flutter/material.dart';
import '../models/subscription_model.dart';

class SubscriptionController extends ChangeNotifier {
  List<SubscriptionModel> _subscriptions = [];
  List<SubscriptionModel> get subscriptions => _subscriptions;

  void subscribe(SubscriptionModel sub) {
    _subscriptions.add(sub);
    notifyListeners();
  }
}
