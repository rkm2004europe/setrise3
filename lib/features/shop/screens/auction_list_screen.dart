// lib/features/shop/screens/auction_list_screen.dart
//
// شاشة قائمة المزادات — تعرض كل المزادات النشطة
//
// الإصلاحات:
//   - ربط القائمة بـ AuctionController بدل mockAuctions مباشرة
//   - تحويل StatelessWidget إلى StatefulWidget + استماع للتحديثات
//   - استدعاء loadAuctions() في initState
//   - عرض مؤشر تحميل وحالة فارغة وخطأ
//   - إزالة الـ _TopBar كـ StatelessWidget منفصل (نمط شاذ)

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/auction_card.dart';
import '../controllers/auction_controller.dart';
import 'auction_detail_screen.dart';

class AuctionListScreen extends StatefulWidget {
  const AuctionListScreen({super.key});

  @override
  State<AuctionListScreen> createState() => _AuctionListScreenState();
}

class _AuctionListScreenState extends State<AuctionListScreen> {
  final _ctrl = AuctionController();

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_onChanged);
    _ctrl.loadAuctions();
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
                        onTap: () => _ctrl.loadAuctions(),
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
            else if (_ctrl.auctions.isEmpty)
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.gavel, size: 64, color: ShopColors.text2),
                      SizedBox(height: 12),
                      Text('لا توجد مزادات حالياً',
                          style: TextStyle(color: ShopColors.text2)),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: RefreshIndicator(
                  color: ShopColors.accent,
                  onRefresh: () => _ctrl.loadAuctions(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _ctrl.auctions.length,
                    itemBuilder: (_, i) {
                      final auction = _ctrl.auctions[i];
                      return AuctionCard(
                        auction: auction,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AuctionDetailScreen(auction: auction),
                          ),
                        ),
                      );
                    },
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
              'المزادات',
              style: TextStyle(
                color: ShopColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            if (_ctrl.auctions.isNotEmpty)
              Text(
                '${_ctrl.activeAuctions.length} نشط',
                style: const TextStyle(color: ShopColors.green, fontSize: 13),
              ),
          ],
        ),
      );
}
