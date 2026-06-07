import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/filters_data.dart';

class FilterBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onFilterChanged;
  final double intensity;
  final ValueChanged<double> onIntensityChanged;

  const FilterBar({
    super.key,
    required this.selectedIndex,
    required this.onFilterChanged,
    required this.intensity,
    required this.onIntensityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: availableFilters.length,
            itemBuilder: (context, index) {
              final f = availableFilters[index];
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => onFilterChanged(index),
                child: Container(
                  width: 70,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? PostColors.accent : Colors.white10,
                    borderRadius: BorderRadius.circular(14),
                    border: isSelected
                        ? Border.all(color: PostColors.accent, width: 2)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(f.name[0],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(f.name,
                          style: TextStyle(
                              color: isSelected
                                  ? PostColors.accent
                                  : Colors.white70,
                              fontSize: 10)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        if (selectedIndex != 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text('Intensity',
                    style: TextStyle(color: Colors.white54, fontSize: 12)),
                Expanded(
                  child: Slider(
                    value: intensity,
                    min: 0.0,
                    max: 1.5,
                    activeColor: PostColors.accent,
                    inactiveColor: Colors.white24,
                    onChanged: onIntensityChanged,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
