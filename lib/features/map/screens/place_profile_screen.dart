import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/place_model.dart';

class PlaceProfileScreen extends StatelessWidget {
  final PlaceModel place;
  const PlaceProfileScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              Center(child: Text(place.imageEmoji ?? '📍', style: const TextStyle(fontSize: 64))),
              const SizedBox(height: 12),
              Text(place.name, style: const TextStyle(color: MapColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
              Text(place.type, style: const TextStyle(color: MapColors.text2)),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.star, color: MapColors.gold, size: 18),
                Text(' ${place.rating} (${place.reviewCount})', style: const TextStyle(color: MapColors.text2)),
              ]),
              const SizedBox(height: 12),
              Text(place.address, style: const TextStyle(color: MapColors.text2)),
              if (place.hasPromo)
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: MapColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Text(place.promoText ?? 'عرض خاص', style: const TextStyle(color: MapColors.accent)),
                ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: MapColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('عرض المنتجات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: MapColors.text)),
  ]);
}
