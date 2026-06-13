import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/product_model.dart';
import '../widgets/review_card.dart';
import '../../comment/screens/comments_screen.dart';
import '../../shar/screens/share_sheet.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المنتج
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(color: ShopColors.surface),
                child: Center(child: Text(product.images[0], style: const TextStyle(fontSize: 120))),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(color: ShopColors.text, fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('\$${product.price}', style: const TextStyle(color: ShopColors.accent, fontSize: 24, fontWeight: FontWeight.w900)),
                        if (product.oldPrice != null) ...[
                          const SizedBox(width: 8),
                          Text('\$${product.oldPrice}', style: const TextStyle(color: ShopColors.text2, decoration: TextDecoration.lineThrough)),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(product.description, style: const TextStyle(color: ShopColors.text2, height: 1.5)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.store, color: ShopColors.text2, size: 16),
                        const SizedBox(width: 4),
                        Text(product.sellerName, style: const TextStyle(color: ShopColors.text2)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommentsScreen(contextId: product.id, contextName: product.name, accent: ShopColors.accent))),
                          child: const Icon(Icons.comment, color: ShopColors.accent),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () => ShareSheet.show(context, data: ShareData(id: product.id, title: product.name, subtitle: product.description, accentColor: ShopColors.accent)),
                          child: const Icon(Icons.share, color: ShopColors.accent),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // أزرار الشراء
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(color: ShopColors.accent, borderRadius: BorderRadius.circular(14)),
                              child: const Center(child: Text('أضف للسلة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(color: ShopColors.green, borderRadius: BorderRadius.circular(14)),
                              child: const Center(child: Text('اشتري الآن', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (product.codAvailable) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: ShopColors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                        child: const Row(children: [
                          Icon(Icons.handshake, color: ShopColors.green, size: 18),
                          SizedBox(width: 8),
                          Text('الدفع عند الاستلام متاح', style: TextStyle(color: ShopColors.green, fontWeight: FontWeight.w600)),
                        ]),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// نفس الملف السابق مع إضافة الأزرار الجديدة في صف الأدوات
// ...
import '../widgets/wishlist_button.dart';
import '../widgets/share_product_button.dart';

// في build، داخل Column بعد Row البائع:
Row(
  children: [
    const Icon(Icons.store, color: ShopColors.text2, size: 16),
    const SizedBox(width: 4),
    Text(product.sellerName, style: const TextStyle(color: ShopColors.text2)),
    const Spacer(),
    WishlistButton(isInWishlist: false, onToggle: () {}),
    const SizedBox(width: 12),
    ShareProductButton(productId: product.id, productName: product.name, description: product.description),
  ],
),
