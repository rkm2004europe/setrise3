import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class LocationPickerSheet extends StatefulWidget {
  final Function(String location) onLocationSelected;
  const LocationPickerSheet({super.key, required this.onLocationSelected});

  @override
  State<LocationPickerSheet> createState() => _LocationPickerSheetState();
}

class _LocationPickerSheetState extends State<LocationPickerSheet> {
  final _searchCtrl = TextEditingController();

  final List<String> _popularLocations = [
    'New York, USA',
    'London, UK',
    'Tokyo, Japan',
    'Paris, France',
    'Algiers, Algeria',
    'Dubai, UAE',
    'Custom Location...',
  ];

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
            const Text('Add Location',
                style: TextStyle(
                    color: PostColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchCtrl,
                style: const TextStyle(color: PostColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search location...',
                  hintStyle: TextStyle(color: PostColors.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: PostColors.textSecondary),
                  filled: true,
                  fillColor: PostColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _popularLocations.length,
                itemBuilder: (context, index) {
                  final loc = _popularLocations[index];
                  return ListTile(
                    leading: const Icon(Icons.location_on,
                        color: Colors.greenAccent),
                    title: Text(loc,
                        style: const TextStyle(
                            color: PostColors.textPrimary)),
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      widget.onLocationSelected(loc);
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
