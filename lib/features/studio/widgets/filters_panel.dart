library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../filters/filter_registry.dart';
import '../theme/studio_colors.dart';

/// The currently selected filter ID.
final selectedFilterProvider = StateProvider<String>((ref) => 'none');

/// Filter intensity (0..1) — reserved for future use.
final filterIntensityProvider = StateProvider<double>((ref) => 1.0);

/// Shows the filters panel as a bottom sheet.
void showFiltersPanel(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: StudioColors.surfaceRaised,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(StudioRadius.xl),
      ),
    ),
    builder: (_) => const FiltersPanel(),
  );
}

class FiltersPanel extends ConsumerWidget {
  const FiltersPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedFilterProvider);
    final intensity = ref.watch(filterIntensityProvider);

    return Container(
      padding: const EdgeInsets.all(StudioSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: StudioSpacing.lg),
              decoration: BoxDecoration(
                color: StudioColors.separator,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: StudioColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done',
                    style: TextStyle(color: StudioColors.accent)),
              ),
            ],
          ),
          const SizedBox(height: StudioSpacing.lg),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: FilterRegistry.all().length,
              itemBuilder: (context, i) {
                final filter = FilterRegistry.all()[i];
                final isSelected = filter.id == selected;
                return _FilterTile(
                  filter: filter,
                  isSelected: isSelected,
                  onTap: () {
                    ref.read(selectedFilterProvider.notifier).state =
                        filter.id;
                  },
                );
              },
            ),
          ),
          if (selected != 'none') ...[
            const SizedBox(height: StudioSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Intensity',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: StudioColors.textSecondary)),
                Text('${(intensity * 100).round()}%',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: StudioColors.accent)),
              ],
            ),
            Slider(
              value: intensity,
              onChanged: (v) =>
                  ref.read(filterIntensityProvider.notifier).state = v,
              activeColor: StudioColors.accent,
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterTile extends StatelessWidget {
  const _FilterTile({
    required this.filter,
    required this.isSelected,
    required this.onTap,
  });

  final FilterDescriptor filter;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: StudioSpacing.md),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(StudioRadius.md),
                border: Border.all(
                  color: isSelected
                      ? StudioColors.accent
                      : StudioColors.separator,
                  width: isSelected ? 3 : 1,
                ),
                gradient: _getPreviewGradient(filter.id),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.check,
                          color: Colors.white, size: 28),
                    )
                  : null,
            ),
            const SizedBox(height: 6),
            Text(
              filter.name,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? StudioColors.accent
                    : StudioColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Gradient? _getPreviewGradient(String id) {
    switch (id) {
      case 'none':
        return const LinearGradient(
          colors: [Color(0xFF4A4A4A), Color(0xFF2A2A2A)],
        );
      case 'vivid':
        return const LinearGradient(
          colors: [Color(0xFFFF375F), Color(0xFFA855F7)],
        );
      case 'warm':
        return const LinearGradient(
          colors: [Color(0xFFFF9500), Color(0xFFFF2D55)],
        );
      case 'cool':
        return const LinearGradient(
          colors: [Color(0xFF007AFF), Color(0xFF64D2FF)],
        );
      case 'grayscale':
      case 'sepia':
      case 'invert':
        return const LinearGradient(
          colors: [Color(0xFF8E8E93), Color(0xFF3A3A3C)],
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF4A4A4A), Color(0xFF2A2A2A)],
        );
    }
  }
}
