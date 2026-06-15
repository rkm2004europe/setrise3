import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AdvancedCompareScreen extends StatelessWidget {
  const AdvancedCompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(ShopColors.surface),
                    dataRowColor: WidgetStateProperty.all(ShopColors.bg),
                    columns: const [
                      DataColumn(label: Text('المواصفة', style: TextStyle(color: ShopColors.text))),
                      DataColumn(label: Text('المنتج 1', style: TextStyle(color: ShopColors.text))),
                      DataColumn(label: Text('المنتج 2', style: TextStyle(color: ShopColors.text))),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('السعر', style: TextStyle(color: ShopColors.text))),
                        DataCell(Text('\$200', style: TextStyle(color: ShopColors.accent))),
                        DataCell(Text('\$250', style: TextStyle(color: ShopColors.accent))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('التقييم', style: TextStyle(color: ShopColors.text))),
                        DataCell(Text('4.5', style: TextStyle(color: ShopColors.gold))),
                        DataCell(Text('4.2', style: TextStyle(color: ShopColors.gold))),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
    const SizedBox(width: 12),
    const Text('مقارنة', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
