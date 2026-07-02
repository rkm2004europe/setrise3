import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/category_chips.dart';
import '../controllers/explore_controller.dart';

class GenreDiscoveryScreen extends StatefulWidget {
  const GenreDiscoveryScreen({super.key});

  @override
  State<GenreDiscoveryScreen> createState() => _GenreDiscoveryScreenState();
}

class _GenreDiscoveryScreenState extends State<GenreDiscoveryScreen> {
  final ExploreController _ctrl = ExploreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: MusicColors.text)),
                const SizedBox(width: 12),
                const Text('Genre Discovery', style: TextStyle(color: MusicColors.text, fontSize: 22, fontWeight: FontWeight.w900)),
              ]),
            ),
            CategoryChips(selected: _ctrl.selectedCategory, onChanged: (v) => _ctrl.selectCategory(v)),
          ],
        ),
      ),
    );
  }
}
