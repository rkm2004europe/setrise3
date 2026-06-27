library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ai/whisper_transcription_service.dart';
import '../commands/editing_commands.dart';
import '../entities/layer.dart';
import '../entities/track.dart';
import '../state/studio_session.dart';
import '../theme/studio_colors.dart';
import '../widgets/studio_button.dart';

class AutoCaptionsScreen extends ConsumerStatefulWidget {
  const AutoCaptionsScreen({super.key});

  @override
  ConsumerState<AutoCaptionsScreen> createState() =>
      _AutoCaptionsScreenState();
}

class _AutoCaptionsScreenState extends ConsumerState<AutoCaptionsScreen> {
  final WhisperTranscriptionService _whisper =
      WhisperTranscriptionService();
  bool _isGenerating = false;
  double _progress = 0;
  String _statusText = '';
  List<WhisperSegment> _segments = const [];
  WhisperModel _selectedModel = WhisperModel.small;
  String _selectedLanguage = 'ar';
  bool _translateToEnglish = false;

  @override
  void dispose() {
    _whisper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StudioColors.canvas,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _isGenerating
                  ? _buildGeneratingView()
                  : _segments.isEmpty
                      ? _buildConfigView()
                      : _buildResultsView(),
            ),
            if (!_isGenerating && _segments.isNotEmpty)
              _buildApplyButton(),
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
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Spacer(),
          const Text('Auto Captions',
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

  Widget _buildConfigView() {
    return ListView(
      padding: const EdgeInsets.all(StudioSpacing.xl),
      children: [
        const Text('🤖 AI Auto Captions',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: StudioColors.textPrimary)),
        const SizedBox(height: StudioSpacing.sm),
        const Text(
            'Whisper runs on your device — no internet needed.',
            style: TextStyle(
                fontSize: 13, color: StudioColors.textSecondary)),
        const SizedBox(height: StudioSpacing.xxl),
        const Text('Language',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: StudioColors.textSecondary)),
        const SizedBox(height: StudioSpacing.md),
        Wrap(
          spacing: StudioSpacing.sm,
          children: WhisperLanguages.supported.entries
              .take(10)
              .map((e) {
            final selected = e.key == _selectedLanguage;
            return ChoiceChip(
              label: Text(e.value),
              selected: selected,
              onSelected: (_) =>
                  setState(() => _selectedLanguage = e.key),
              selectedColor: StudioColors.accent,
              labelStyle: TextStyle(
                  color: selected
                      ? Colors.white
                      : StudioColors.textSecondary,
                  fontWeight: FontWeight.w600),
            );
          }).toList(),
        ),
        const SizedBox(height: StudioSpacing.xl),
        const Text('Model Quality',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: StudioColors.textSecondary)),
        const SizedBox(height: StudioSpacing.md),
        ...WhisperModel.values.map((m) => _buildModelOption(m)),
        const SizedBox(height: StudioSpacing.xxl),
        StudioButton(
          label: 'Generate Captions',
          icon: Icons.auto_awesome,
          size: StudioButtonSize.large,
          fullWidth: true,
          onPressed: _startGeneration,
        ),
      ],
    );
  }

  Widget _buildModelOption(WhisperModel m) {
    final selected = m == _selectedModel;
    return GestureDetector(
      onTap: () => setState(() => _selectedModel = m),
      child: Container(
        margin: const EdgeInsets.only(bottom: StudioSpacing.sm),
        padding: const EdgeInsets.all(StudioSpacing.md),
        decoration: BoxDecoration(
          color: selected
              ? StudioColors.accent.withOpacity(0.1)
              : StudioColors.surfaceRaised,
          borderRadius: BorderRadius.circular(StudioRadius.md),
          border: Border.all(
              color: selected ? StudioColors.accent : Colors.transparent,
              width: 1.5),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? StudioColors.accent
                  : StudioColors.textTertiary,
              size: 20,
            ),
            const SizedBox(width: StudioSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${m.name[0].toUpperCase()}${m.name.substring(1)} (${m.sizeHint})',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? StudioColors.accent
                            : StudioColors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text(m.recommendation,
                      style: const TextStyle(
                          fontSize: 11,
                          color: StudioColors.textTertiary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneratingView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(StudioSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                  strokeWidth: 4, color: StudioColors.accent),
            ),
            const SizedBox(height: StudioSpacing.xl),
            Text('${(_progress * 100).round()}%',
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: StudioColors.textPrimary)),
            const SizedBox(height: StudioSpacing.sm),
            Text(_statusText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13, color: StudioColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsView() {
    return ListView.builder(
      padding: const EdgeInsets.all(StudioSpacing.lg),
      itemCount: _segments.length,
      itemBuilder: (_, i) {
        final s = _segments[i];
        return Container(
          margin: const EdgeInsets.only(bottom: StudioSpacing.sm),
          padding: const EdgeInsets.all(StudioSpacing.md),
          decoration: BoxDecoration(
            color: StudioColors.surfaceRaised,
            borderRadius: BorderRadius.circular(StudioRadius.md),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: StudioColors.accent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${(s.start / 1000000).toStringAsFixed(1)}s',
                  style: const TextStyle(
                      color: StudioColors.accent,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: StudioSpacing.sm),
              Expanded(
                child: Text(s.text.trim(),
                    style: const TextStyle(
                        color: StudioColors.textPrimary,
                        fontSize: 13,
                        height: 1.4)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildApplyButton() {
    return Padding(
      padding: const EdgeInsets.all(StudioSpacing.xl),
      child: StudioButton(
        label: 'Add ${_segments.length} captions to timeline',
        icon: Icons.check,
        size: StudioButtonSize.large,
        fullWidth: true,
        onPressed: _applyCaptions,
      ),
    );
  }

  Future<void> _startGeneration() async {
    setState(() {
      _isGenerating = true;
      _progress = 0;
      _statusText = 'Loading model...';
    });

    final session = ref.read(studioSessionProvider);

    _whisper.transcriptionProgress.listen((p) {
      if (mounted) {
        setState(() {
          _progress = p;
          _statusText =
              'Transcribing audio... ${(p * 100).round()}%';
        });
      }
    });

    try {
      final videoLayer = session.project.layers
          .whereType<VideoLayer>()
          .firstWhere(
            (l) {
              final source = session.project.sourceById(l.source);
              return source?.mapOrNull(file: (s) => s.path) != null;
            },
            orElse: () =>
                throw StateError('No video layer with a local file'),
          );
      final videoPath = session.project
          .sourceById(videoLayer.source)!
          .mapOrNull(file: (s) => s.path)!;

      final segments = await _whisper.transcribeVideo(
        videoPath,
        WhisperTranscriptionOptions(
          model: _selectedModel,
          languageCode: _selectedLanguage,
          translateToEnglish: _translateToEnglish,
        ),
      );

      if (mounted) {
        setState(() {
          _segments = segments;
          _isGenerating = false;
        });
      }
    } on Object catch (e) {
      if (mounted) {
        setState(() {
          _isGenerating = false;
          _statusText = 'Error: $e';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  void _applyCaptions() {
    final session = ref.read(studioSessionProvider);
    final notifier = ref.read(studioSessionProvider.notifier);

    var textTrack = session.project.tracks.firstWhere(
      (t) => t.kind == TrackKind.text,
      orElse: () => StudioTrack.create(
          id: 'track_captions', kind: TrackKind.text, name: 'Captions'),
    );

    final layers = _whisper.toTextLayers(
      _segments,
      trackId: textTrack.id,
      preset: StudioTextPreset.tiktokCaption,
    );

    for (final layer in layers) {
      notifier.execute(AddTextCommand(layer: layer));
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text('Added ${layers.length} captions to timeline')),
    );
  }
}
