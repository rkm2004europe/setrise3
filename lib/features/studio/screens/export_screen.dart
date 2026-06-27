library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../export/export_settings.dart';
import '../state/studio_session.dart';
import '../theme/studio_colors.dart';
import '../widgets/studio_button.dart';

class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  ExportQuality _quality = ExportQuality.high;
  ExportFormat _format = ExportFormat.mp4H264;
  bool _includeAudio = true;
  bool _isExporting = false;
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StudioColors.canvas,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(StudioSpacing.xl),
                children: [
                  _buildSection('Quality'),
                  _buildQualitySelector(),
                  const SizedBox(height: StudioSpacing.xl),
                  _buildSection('Format'),
                  _buildFormatSelector(),
                  const SizedBox(height: StudioSpacing.xl),
                  _buildSection('Audio'),
                  _buildToggle(
                    value: _includeAudio,
                    onChanged: (v) =>
                        setState(() => _includeAudio = v),
                  ),
                  if (_isExporting) ...[
                    const SizedBox(height: StudioSpacing.xxl),
                    LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: StudioColors.surfaceRaised,
                      color: StudioColors.accent,
                    ),
                    const SizedBox(height: StudioSpacing.md),
                    Text('${(_progress * 100).toInt()}%',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: StudioColors.textSecondary,
                            fontWeight: FontWeight.w600)),
                  ],
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(StudioSpacing.md),
      child: Row(
        children: [
          StudioButton(
            icon: Icons.close,
            label: '',
            variant: StudioButtonVariant.secondary,
            onPressed: () => context.pop(),
          ),
          const Spacer(),
          const Text('Export',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: StudioColors.textPrimary)),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: StudioSpacing.md),
      child: Text(title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: StudioColors.textSecondary)),
    );
  }

  Widget _buildQualitySelector() {
    return Wrap(
      spacing: StudioSpacing.sm,
      children: ExportQuality.values.map((q) {
        final selected = q == _quality;
        return ChoiceChip(
          label: Text(q.name.toUpperCase()),
          selected: selected,
          onSelected: (_) => setState(() => _quality = q),
          selectedColor: StudioColors.accent,
          labelStyle: TextStyle(
              color: selected ? Colors.white : StudioColors.textSecondary,
              fontWeight: FontWeight.w600),
        );
      }).toList(),
    );
  }

  Widget _buildFormatSelector() {
    return Wrap(
      spacing: StudioSpacing.sm,
      children: ExportFormat.values.map((f) {
        final selected = f == _format;
        return ChoiceChip(
          label: Text(f.name.toUpperCase()),
          selected: selected,
          onSelected: (_) => setState(() => _format = f),
          selectedColor: StudioColors.accent,
          labelStyle: TextStyle(
              color: selected ? Colors.white : StudioColors.textSecondary,
              fontWeight: FontWeight.w600),
        );
      }).toList(),
    );
  }

  Widget _buildToggle({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: StudioSpacing.md, vertical: StudioSpacing.sm),
      decoration: BoxDecoration(
        color: StudioColors.surfaceRaised,
        borderRadius: BorderRadius.circular(StudioRadius.md),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Include audio',
              style: TextStyle(
                  fontSize: 15,
                  color: StudioColors.textPrimary,
                  fontWeight: FontWeight.w500)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: StudioColors.accent,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(StudioSpacing.xl),
      child: StudioButton(
        label: _isExporting ? 'Exporting…' : 'Export',
        icon: Icons.download_rounded,
        size: StudioButtonSize.large,
        fullWidth: true,
        isLoading: _isExporting,
        onPressed: _isExporting ? null : _startExport,
      ),
    );
  }

  Future<void> _startExport() async {
    setState(() => _isExporting = true);
    final session = ref.read(studioSessionProvider);
    final settings = ExportSettings(
      format: _format,
      quality: _quality,
      includeAudio: _includeAudio,
      aspectRatio: session.project.aspectRatio,
    );

    for (var i = 0; i <= 100; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 30));
      setState(() => _progress = i / 100);
    }
    setState(() => _isExporting = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Export complete')),
      );
      context.go('/');
    }
  }
}
