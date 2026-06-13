import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TravelModeScreen extends StatefulWidget {
  const TravelModeScreen({super.key});

  @override
  State<TravelModeScreen> createState() => _TravelModeScreenState();
}

class _TravelModeScreenState extends State<TravelModeScreen> {
  String _city = 'الجزائر العاصمة';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text('اختر المدينة التي ستسافر إليها', style: TextStyle(color: DateColors.text, fontSize: 16)),
                  const SizedBox(height: 12),
                  _CityTile(name: 'دبي', selected: _city == 'دبي', onTap: () => setState(() => _city = 'دبي')),
                  _CityTile(name: 'باريس', selected: _city == 'باريس', onTap: () => setState(() => _city = 'باريس')),
                  _CityTile(name: 'لندن', selected: _city == 'لندن', onTap: () => setState(() => _city = 'لندن')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: DateColors.text)),
      const SizedBox(width: 12),
      const Text('وضع السفر', style: TextStyle(color: DateColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}

class _CityTile extends StatelessWidget {
  final String name; final bool selected; final VoidCallback onTap;
  const _CityTile({required this.name, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(name, style: const TextStyle(color: DateColors.text)),
    trailing: selected ? const Icon(Icons.check, color: DateColors.accent) : null,
    onTap: onTap,
  );
}
