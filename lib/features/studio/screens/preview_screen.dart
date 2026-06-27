library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/studio_session.dart';
import '../theme/studio_colors.dart';
import '../widgets/preview_canvas.dart';
import '../widgets/studio_button.dart';

class PreviewScreen extends ConsumerWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(studioSessionProvider);

    return Scaffold(
      backgroundColor: StudioColors.canvas,
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: PreviewCanvas(project: session.project)),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(StudioSpacing.md),
                child: Row(
                  children: [
                    StudioButton(
                      icon: Icons.arrow_back_ios,
                      label: '',
                      variant: StudioButtonVariant.secondary,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(StudioSpacing.xl),
                child: StudioButton(
                  label: 'Export',
                  icon: Icons.download_rounded,
                  size: StudioButtonSize.large,
                  fullWidth: true,
                  onPressed: () => context.push('/export'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
