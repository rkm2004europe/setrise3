import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/product_model.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
      child: Container(
        decoration: BoxDecoration(color: ShopColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: ShopColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(child: Text(product.images[0], style: const TextStyle(fontSize: 48))),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: ShopColors.text, fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('\$${product.price}', style: const TextStyle(color: ShopColors.accent, fontWeight: FontWeight.w800)),
                      if (product.oldPrice != null) ...[
                        const SizedBox(width: 6),
                        Text('\$${product.oldPrice}', style: const TextStyle(color: ShopColors.text2, decoration: TextDecoration.lineThrough, fontSize: 12)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: ShopColors.gold, size: 14),
                      Text(' ${product.rating}', style: const TextStyle(color: ShopColors.text2, fontSize: 11)),
                      const SizedBox(width: 6),
                      Text('(${product.reviewCount})', style: const TextStyle(color: ShopColors.text2, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
