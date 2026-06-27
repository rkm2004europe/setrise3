library;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

import '../theme/studio_colors.dart';

class ImageEditorScreen extends ConsumerStatefulWidget {
  const ImageEditorScreen({
    super.key,
    required this.imageBytes,
    this.onSave,
  });

  final Uint8List imageBytes;
  final ValueChanged<Uint8List>? onSave;

  @override
  ConsumerState<ImageEditorScreen> createState() =>
      _ImageEditorScreenState();
}

class _ImageEditorScreenState extends ConsumerState<ImageEditorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StudioColors.canvas,
      body: SafeArea(
        child: ProImageEditor.memory(
          widget.imageBytes,
          callbacks: ProImageEditorCallbacks(
            onImageEditingComplete: (bytes) async {
              widget.onSave?.call(bytes);
              if (mounted) Navigator.of(context).pop(bytes);
            },
          ),
          configs: ProImageEditorConfigs(
            theme: ProImageEditorTheme(
              backdropColor: StudioColors.canvas,
              bottomBarColor: StudioColors.surface,
              bottomBarActiveColor: StudioColors.accent,
              bottomBarInactiveColor: StudioColors.textTertiary,
              titleTextStyle: const TextStyle(
                color: StudioColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              textStyle: const TextStyle(color: StudioColors.textPrimary),
            ),
            cropRotateEditorConfigs: const CropRotateEditorConfigs(
              enabled: true,
              canFlip: true,
              canRotate: true,
              aspectRatios: [
                AspectRatioItem(text: 'Free', value: null),
                AspectRatioItem(text: '9:16', value: 9 / 16),
                AspectRatioItem(text: '4:5', value: 4 / 5),
                AspectRatioItem(text: '1:1', value: 1.0),
                AspectRatioItem(text: '4:3', value: 4 / 3),
                AspectRatioItem(text: '16:9', value: 16 / 9),
              ],
            ),
            filterEditorConfigs: FilterEditorConfigs(
              enabled: true,
              filters: presetFiltersList,
            ),
            stickerEditorConfigs: StickerEditorConfigs(
              enabled: true,
              initWidth: 100,
              builder: _buildStickerSheet,
            ),
            textEditorConfigs:
                const TextEditorConfigs(enabled: true, initFontSize: 32),
            paintEditorConfigs:
                const PaintEditorConfigs(enabled: true, showSelectColor: true),
          ),
        ),
      ),
    );
  }

  Widget _buildStickerSheet(BuildContext context) {
    final emojis = [
      '😀', '😂', '😍', '🥰', '😎', '🤩', '🔥', '💯',
      '👍', '👏', '🙌', '🎉', '❤️', '💔', '✨', '⭐'
    ];
    return Container(
      color: StudioColors.surface,
      height: 240,
      child: GridView.builder(
        padding: const EdgeInsets.all(StudioSpacing.md),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          mainAxisSpacing: StudioSpacing.sm,
          crossAxisSpacing: StudioSpacing.sm,
        ),
        itemCount: emojis.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => Navigator.pop(context, emojis[i]),
          child: Center(
            child: Text(emojis[i], style: const TextStyle(fontSize: 28)),
          ),
        ),
      ),
    );
  }
}
