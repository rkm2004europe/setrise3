import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class ProductTagSheet extends StatefulWidget {
  final Function(String productName) onProductSelected;
  const ProductTagSheet({super.key, required this.onProductSelected});

  @override
  State<ProductTagSheet> createState() => _ProductTagSheetState();
}

class _ProductTagSheetState extends State<ProductTagSheet> {
  final _searchCtrl = TextEditingController();
  final List<Map<String, String>> _allProducts = [
    {'name': 'Sneakers Pro X', 'price': '\$120', 'shop': 'StreetWear'},
    {'name': 'Wireless Headphones', 'price': '\$89', 'shop': 'AudioHub'},
    {'name': 'Smart Watch S', 'price': '\$199', 'shop': 'TechZone'},
    {'name': 'Perfume Night', 'price': '\$65', 'shop': 'LuxuryScents'},
  ];

  List<Map<String, String>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
  }

  void _filter(String query) {
    setState(() {
      _filteredProducts = _allProducts
          .where((p) => p['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PostColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4,
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchCtrl,
                style: const TextStyle(color: PostColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: PostColors.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: PostColors.textSecondary),
                  filled: true,
                  fillColor: PostColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: _filter,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.shopping_bag, color: Colors.orangeAccent),
                    ),
                    title: Text(product['name']!,
                        style: const TextStyle(
                            color: PostColors.textPrimary,
                            fontWeight: FontWeight.w600)),
                    subtitle: Text('${product['price']} • ${product['shop']}',
                        style: const TextStyle(color: PostColors.textSecondary)),
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      widget.onProductSelected(product['name']!);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
