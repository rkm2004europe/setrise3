import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/place_model.dart';
import '../../shop/screens/product_detail_screen.dart';
import '../../shop/models/product_model.dart';

class PlaceInfoSheet extends StatelessWidget {
  final PlaceModel place;
  const PlaceInfoSheet({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: MapColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Row(children: [
            Text(place.imageEmoji ?? '📍', style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 10),
            Expanded(child: Text(place.name, style: const TextStyle(color: MapColors.text, fontSize: 20, fontWeight: FontWeight.w800))),
          ]),
          const SizedBox(height: 4),
          Text(place.type, style: const TextStyle(color: MapColors.text2)),
          const SizedBox(height: 8),
          if (place.hasPromo)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: MapColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                const Icon(Icons.local_offer, color: MapColors.accent),
                const SizedBox(width: 8),
                Text(place.promoText ?? 'عرض خاص', style: const TextStyle(color: MapColors.accent)),
              ]),
            ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: ProductModel(
                id: place.id, name: place.name, description: place.address, price: 0, images: [place.imageEmoji ?? '📍'], category: place.type,
                sellerId: '', sellerName: '', rating: place.rating, reviewCount: place.reviewCount, stock: 1,
              ))));
            },
            child: Container(
              width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(color: MapColors.accent, borderRadius: BorderRadius.circular(14)),
              child: const Center(child: Text('عرض التفاصيل', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
            ),
          ),
        ],
      ),
    );
  }
}
