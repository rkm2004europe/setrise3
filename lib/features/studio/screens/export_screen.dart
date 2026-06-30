/// Export screen — REAL export via [ExportPipeline].
///
/// Calls the actual [ExportPipeline.export()] which uses either
/// [FFmpegRenderAdapter] or [EasyVideoEditorAdapter] to render the
/// project to an MP4 file. Shows real progress from the stream.
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../entities/layer.dart'; // ✅ FIX: Added missing import for VideoLayer
import '../export/export_pipeline.dart';
import '../export/export_settings.dart';
import '../state/pending_import.dart';
import '../state/studio_session.dart';
import '../theme/studio_colors.dart';
import '../utils/id_generator.dart';
import '../widgets/filters_panel.dart';
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
  String _statusText = '';
  String? _outputPath;

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
                    onChanged: (v) => setState(() => _includeAudio = v),
                  ),
                  if (_isExporting) ...[
                    const SizedBox(height: StudioSpacing.xxl),
                    _buildProgressIndicator(),
                  ],
                  if (_outputPath != null && !_isExporting) ...[
                    const SizedBox(height: StudioSpacing.xl),
                    _buildSuccessCard(),
                  ],
                ],
              ),
            ),
            if (!_isExporting) _buildFooter(),
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

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(StudioSpacing.xl),
      decoration: BoxDecoration(
        color: StudioColors.surfaceRaised,
        borderRadius: BorderRadius.circular(StudioRadius.lg),
      ),
      child: Column(
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: StudioColors.accent,
            ),
          ),
          const SizedBox(height: StudioSpacing.lg),
          Text(
            '${(_progress * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: StudioColors.textPrimary,
            ),
          ),
          const SizedBox(height: StudioSpacing.sm),
          Text(
            _statusText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: StudioColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: StudioSpacing.lg),
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: StudioColors.separator,
            color: StudioColors.accent,
            minHeight: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessCard() {
    return Container(
      padding: const EdgeInsets.all(StudioSpacing.lg),
      decoration: BoxDecoration(
        color: StudioColors.accentTertiary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(StudioRadius.lg),
        border: Border.all(
            color: StudioColors.accentTertiary.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle,
              color: StudioColors.accentTertiary, size: 48),
          const SizedBox(height: StudioSpacing.md),
          const Text('Export complete!',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: StudioColors.textPrimary)),
          const SizedBox(height: StudioSpacing.sm),
          Text(
            'Saved to: ${_outputPath!.split('/').last}',
            style: const TextStyle(
                color: StudioColors.textSecondary, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: StudioSpacing.lg),
          Row(
            children: [
              Expanded(
                child: StudioButton(
                  label: 'Save to Gallery',
                  icon: Icons.save_alt,
                  size: StudioButtonSize.medium,
                  variant: StudioButtonVariant.secondary,
                  onPressed: _saveToGallery,
                ),
              ),
              const SizedBox(width: StudioSpacing.sm),
              Expanded(
                child: StudioButton(
                  label: 'Done',
                  icon: Icons.check,
                  size: StudioButtonSize.medium,
                  onPressed: () => context.go('/editor'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(StudioSpacing.xl),
      child: StudioButton(
        label: _outputPath != null ? 'Export Again' : 'Export',
        icon: Icons.download_rounded,
        size: StudioButtonSize.large,
        fullWidth: true,
        onPressed: _startExport,
      ),
    );
  }

  // ── Real export ─────────────────────────────────────────────────────────

  Future<void> _startExport() async {
    setState(() {
      _isExporting = true;
      _progress = 0;
      _statusText = 'Preparing...';
      _outputPath = null;
    });

    final session = ref.read(studioSessionProvider);
    final project = session.project;

    final hasVideo = project.layers.any((l) => l is VideoLayer);
    if (!hasVideo) {
      setState(() {
        _isExporting = false;
        _statusText = 'No video to export';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No video to export. Please add a video layer first.')),
        );
      }
      return;
    }

    // ✅ FIX: Calculate outputPath BEFORE creating settings
    final tempDir = await getTemporaryDirectory();
    final outputPath = p.join(
      tempDir.path,
      'studio_export_${IdGenerator.newExport()}.mp4',
    );

    // ✅ FIX: Pass outputPathOverride to ExportSettings
    final settings = ExportSettings(
      format: _format,
      quality: _quality,
      includeAudio: _includeAudio,
      aspectRatio: project.aspectRatio,
      filterId: ref.read(selectedFilterProvider),
      outputPathOverride: outputPath,
    );

    final exportJob = ExportJob(
      id: IdGenerator.newExport(),
      project: project,
      settings: settings,
    );

    final pipeline = ExportPipeline();

    try {
      await for (final progress in pipeline.export(exportJob)) {
        if (!mounted) return;

        setState(() {
          _progress = progress.fraction;
          _statusText = switch (progress.stage) {
            Stage.queued => 'Queued...',
            Stage.rendering => 'Rendering video... ${(progress.fraction * 100).toInt()}%',
            Stage.postProcessing => 'Applying post-processing...',
            Stage.finalising => 'Finalising...',
            Stage.done => 'Done!',
            Stage.failed => 'Failed: ${progress.message ?? "unknown error"}',
          };
        });

        if (progress.stage == Stage.done) {
          final finalPath = progress.message ?? outputPath;
          if (File(finalPath).existsSync() && finalPath != outputPath) {
            await File(finalPath).copy(outputPath);
          }
          
          setState(() {
            _outputPath = outputPath;
            _isExporting = false;
          });
          ref.read(pendingImportProvider.notifier).state = outputPath;
        }

        if (progress.stage == Stage.failed) {
          setState(() => _isExporting = false);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Export failed: ${progress.message ?? "unknown"}')),
            );
          }
          return;
        }
      }
    } on Object catch (e) {
      if (mounted) {
        setState(() {
          _isExporting = false;
          _statusText = 'Error: $e';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export error: $e')),
        );
      }
    }
  }

  Future<void> _saveToGallery() async {
    if (_outputPath == null) return;
    try {
      await Gal.putVideo(_outputPath!, album: 'Creator Studio');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved to gallery! 📸')),
        );
      }
    } on Object catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save: $e')),
        );
      }
    }
  }
}
