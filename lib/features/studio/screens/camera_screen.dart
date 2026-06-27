library;

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../theme/studio_colors.dart';
import '../widgets/studio_button.dart';

class CameraScreen extends ConsumerWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: StudioColors.canvas,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CameraAwesomeBuilder.awesome(
                saveConfig: SaveConfig.video(),
                onMediaTap: (media) {
                  context.push('/editor');
                },
                sensorConfig: const SensorConfig(sensor: Sensor.back),
                initialCaptureMode: CaptureMode.video,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(StudioSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StudioButton(
                      icon: Icons.close,
                      label: '',
                      variant: StudioButtonVariant.secondary,
                      onPressed: () => context.pop(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: StudioSpacing.md,
                          vertical: StudioSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(StudioRadius.pill),
                      ),
                      child: const Text('9:16',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ),
                    StudioButton(
                      icon: Icons.flash_off,
                      label: '',
                      variant: StudioButtonVariant.secondary,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(StudioSpacing.xl,
                    StudioSpacing.lg, StudioSpacing.xl, StudioSpacing.xxxl),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StudioButton(
                      icon: Icons.photo_library,
                      label: '',
                      variant: StudioButtonVariant.secondary,
                      onPressed: () => context.push('/editor'),
                    ),
                    const _RecordButton(),
                    StudioButton(
                      icon: Icons.flip_camera_ios,
                      label: '',
                      variant: StudioButtonVariant.secondary,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordButton extends StatefulWidget {
  const _RecordButton();

  @override
  State<_RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<_RecordButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isRecording = !_isRecording;
          if (_isRecording) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 1 - (_controller.value * 0.3);
          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape:
                  _isRecording ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
                  _isRecording ? BorderRadius.circular(20) : null,
              border: Border.all(color: Colors.white, width: 4),
              color: _isRecording
                  ? StudioColors.accent
                  : Colors.transparent,
            ),
            child: Transform.scale(
              scale: scale,
              child: Container(
                decoration: const BoxDecoration(
                  color: StudioColors.accent,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.all(8),
              ),
            ),
          );
        },
      ),
    );
  }
}
