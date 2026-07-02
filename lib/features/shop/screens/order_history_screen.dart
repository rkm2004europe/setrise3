// lib/features/shop/screens/order_history_screen.dart
//
// شاشة سجل الطلبات — تعرض طلبات المستخدم السابقة
//
// الإصلاحات:
//   - ربط القائمة بـ OrderController بدل mockOrders مباشرة
//   - استخدام StatefulWidget + استماع للتحديثات
//   - استدعاء loadOrders() في initState
//   - عرض مؤشر تحميل وحالة فارغة وخطأ

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/order_card.dart';
import '../controllers/order_controller.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final _ctrl = OrderController();

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_onChanged);
    _ctrl.loadOrders();
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            if (_ctrl.isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: ShopColors.accent),
                ),
              )
            else if (_ctrl.error != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_ctrl.error!,
                          style: const TextStyle(color: ShopColors.red),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => _ctrl.loadOrders(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: ShopColors.accent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('إعادة المحاولة',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (_ctrl.orders.isEmpty)
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.receipt_long,
                          size: 64, color: ShopColors.text2),
                      SizedBox(height: 12),
                      Text('لا توجد طلبات بعد',
                          style: TextStyle(color: ShopColors.text2)),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: RefreshIndicator(
                  color: ShopColors.accent,
                  onRefresh: () => _ctrl.loadOrders(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _ctrl.orders.length,
                    itemBuilder: (_, i) => OrderCard(order: _ctrl.orders[i]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: ShopColors.text),
            ),
            const SizedBox(width: 12),
            const Text(
              'سجل الطلبات',
              style: TextStyle(
                color: ShopColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            if (_ctrl.orders.isNotEmpty)
              Text(
                '${_ctrl.orders.length} طلب',
                style: const TextStyle(color: ShopColors.text2, fontSize: 13),
              ),
          ],
        ),
      );
}
