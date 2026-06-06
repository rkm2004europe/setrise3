// lib/features/shop/screens/cart/checkout_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';
import 'package:setrise/features/shop/screens/cart/widgets/address_section.dart';
import 'package:setrise/features/shop/screens/cart/widgets/payment_section.dart';
import 'package:setrise/features/shop/screens/cart/widgets/order_summary_section.dart';

class CheckoutScreen extends StatefulWidget {
  final double subtotal, shippingCost, tax, total;

  const CheckoutScreen({
    super.key, required this.subtotal, required this.shippingCost,
    required this.tax, required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _addrIdx = 0;
  int _payIdx  = 0;

  final List<Address> _addresses = const [
    Address(id: '1', name: 'Home', fullName: 'Ahmed Benali',
      street: '123 Rue Didouche Mourad', city: 'Algiers',
      state: 'Alger', zipCode: '16000', country: 'Algeria',
      phone: '+213 555 123 456', isDefault: true),
    Address(id: '2', name: 'Work', fullName: 'Ahmed Benali',
      street: '45 Bd Colonel Amirouche', city: 'Oran',
      state: 'Oran', zipCode: '31000', country: 'Algeria',
      phone: '+213 555 789 012'),
  ];

  final List<PaymentMethod> _methods = const [
    PaymentMethod(id: '1', type: PaymentType.creditCard,
      name: 'Credit Card', icon: CupertinoIcons.creditcard,
      details: '**** **** **** 4242'),
    PaymentMethod(id: '2', type: PaymentType.paypal,
      name: 'PayPal', icon: CupertinoIcons.money_dollar,
      details: 'ahmed@email.com'),
    PaymentMethod(id: '3', type: PaymentType.cashOnDelivery,
      name: 'Cash on Delivery',
      icon: CupertinoIcons.money_dollar_circle,
      details: 'Pay on delivery'),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ShopColors.bg,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: ShopColors.surface,
        middle: Text('Checkout', style: TextStyle(color: Colors.white))),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Shipping Address', style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
            AddressSection(addresses: _addresses,
              selectedIndex: _addrIdx,
              onChanged: (v) => setState(() => _addrIdx = v)),
            const SizedBox(height: 24),
            const Text('Payment Method', style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
            PaymentSection(methods: _methods,
              selectedIndex: _payIdx,
              onChanged: (v) => setState(() => _payIdx = v)),
            const SizedBox(height: 24),
            OrderSummarySection(
              subtotal: widget.subtotal, shipping: widget.shippingCost,
              tax: widget.tax, discount: 0, total: widget.total,
              couponApplied: false),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity,
              child: CupertinoButton(
                color: ShopColors.accent,
                onPressed: () => _confirmOrder(context),
                child: Text(
                  'Place Order • \$${widget.total.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w800)))),
          ])),
      ),
    );
  }

  void _confirmOrder(BuildContext context) {
    showCupertinoDialog(context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Order Placed! 🎉'),
        content: const Text('Your order has been placed successfully.'),
        actions: [CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('OK'))]));
  }
}

