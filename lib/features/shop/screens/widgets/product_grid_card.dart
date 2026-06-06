// lib/features/shop/screens/widgets/product_grid_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class ProductGridCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductGridCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ShopColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Image
          Expanded(child: Stack(children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                product.images.first,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: ShopColors.surface,
                  child: const Center(child: Icon(CupertinoIcons.photo,
                      color: ShopColors.grey, size: 36))),
              )),
            // Discount badge
            if (product.discountPercentage != null)
              Positioned(top: 8, left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: ShopColors.red,
                    borderRadius: BorderRadius.circular(6)),
                  child: Text('-${product.discountPercentage}%',
                    style: const TextStyle(color: Colors.white, fontSize: 10,
                      fontWeight: FontWeight.w800)))),
            // Favorite
            Positioned(top: 8, right: 8,
              child: Container(
                width: 30, height: 30,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle),
                child: Icon(
                  product.isFavorite
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart,
                  color: product.isFavorite ? ShopColors.red : Colors.white,
                  size: 16))),
          ])),
          // Info
          Padding(padding: const EdgeInsets.all(10), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(product.brand, style: const TextStyle(
              color: ShopColors.grey, fontSize: 11)),
            const SizedBox(height: 2),
            Text(product.name, style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
              maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Row(children: [
              Text('\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(color: ShopColors.accent,
                  fontWeight: FontWeight.w800, fontSize: 14)),
              if (product.oldPrice != null) ...[
                const SizedBox(width: 6),
                Text('\$${product.oldPrice!.toStringAsFixed(2)}',
                  style: const TextStyle(color: ShopColors.grey,
                    fontSize: 11, decoration: TextDecoration.lineThrough)),
              ],
            ]),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(CupertinoIcons.star_fill,
                  color: ShopColors.accent, size: 12),
              const SizedBox(width: 3),
              Text('${product.rating}', style: const TextStyle(
                color: ShopColors.grey, fontSize: 11)),
              const SizedBox(width: 4),
              Text('(${product.reviewsCount})', style: const TextStyle(
                color: ShopColors.grey2, fontSize: 11)),
            ]),
          ])),
        ]),
      ),
    );
  }
}

