library;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/audio_screen.dart';
import '../screens/auto_captions_screen.dart';
import '../screens/camera_screen.dart';
import '../screens/editor_screen.dart';
import '../screens/export_screen.dart';
import '../screens/image_editor_screen.dart';
import '../screens/preview_screen.dart';
import '../theme/studio_colors.dart';

/// Holds the [GoRouter] instance for the app.
final studioRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/editor',
    debugLogDiagnostics: true,
    routes: [
      // ── Studio routes (the editor) ────────────────────────────────────
      GoRoute(
        path: '/camera',
        name: 'camera',
        builder: (context, state) => const CameraScreen(),
      ),
      GoRoute(
        path: '/editor',
        name: 'editor',
        builder: (context, state) => const EditorScreen(),
      ),
      GoRoute(
        path: '/preview',
        name: 'preview',
        builder: (context, state) => const PreviewScreen(),
      ),
      GoRoute(
        path: '/export',
        name: 'export',
        builder: (context, state) => const ExportScreen(),
      ),
      GoRoute(
        path: '/audio',
        name: 'audio',
        builder: (context, state) => const AudioScreen(),
      ),
      GoRoute(
        path: '/image-editor',
        name: 'image_editor',
        builder: (context, state) {
          final bytes = state.extra as Uint8List?;
          if (bytes == null) {
            return const Scaffold(
              body: Center(child: Text('Missing image bytes')),
            );
          }
          return ImageEditorScreen(imageBytes: bytes);
        },
      ),
      GoRoute(
        path: '/auto-captions',
        name: 'auto_captions',
        builder: (context, state) => const AutoCaptionsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: StudioColors.canvas,
      body: Center(
        child: Text(
          'Route not found: ${state.uri}',
          style: const TextStyle(color: StudioColors.textPrimary),
        ),
      ),
    ),
  );
});
