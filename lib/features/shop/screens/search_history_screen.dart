import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_search_history.dart';

class SearchHistoryScreen extends StatelessWidget {
  const SearchHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockSearchHistory.length,
                itemBuilder: (_, i) => ListTile(
                  leading: const Icon(Icons.history, color: ShopColors.text2),
                  title: Text(mockSearchHistory[i], style: const TextStyle(color: ShopColors.text)),
                  trailing: const Icon(Icons.close, color: ShopColors.text2),
                  onTap: () {},
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
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ShopColors.text)),
      const SizedBox(width: 12),
      const Text('سجل البحث', style: TextStyle(color: ShopColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
