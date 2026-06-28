library;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../comments/comments_screen.dart';
import '../../discover/discover_screen.dart';
import '../../notifications/notifications_screen.dart';
import '../../profile/profile_screen.dart';
import '../../../shell/main_shell_screen.dart';
import '../../social/models/post_model.dart';
import '../../social/models/story_model.dart';
import '../../social/models/user_model.dart';
import '../../social/providers/social_providers.dart';
import '../../social/screens/post_composer_screen.dart';
import '../../stories/story_viewer_screen.dart';
import '../screens/audio_screen.dart';
import '../screens/auto_captions_screen.dart';
import '../screens/camera_screen.dart';
import '../screens/editor_screen.dart';
import '../screens/export_screen.dart';
import '../screens/image_editor_screen.dart';
import '../screens/preview_screen.dart';
import '../live/go_live_screen.dart';
import '../theme/studio_colors.dart';

final studioRouterProvider = Provider<GoRouter>((ref) {
  final storiesAsync = ref.watch(storiesProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainShellScreen(),
      ),
      GoRoute(path: '/camera', name: 'camera',
        builder: (context, state) => const CameraScreen()),
      GoRoute(path: '/editor', name: 'editor',
        builder: (context, state) => const EditorScreen()),
      GoRoute(path: '/preview', name: 'preview',
        builder: (context, state) => const PreviewScreen()),
      GoRoute(path: '/export', name: 'export',
        builder: (context, state) => const ExportScreen()),
      GoRoute(path: '/audio', name: 'audio',
        builder: (context, state) => const AudioScreen()),
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
      GoRoute(path: '/auto-captions', name: 'auto_captions',
        builder: (context, state) => const AutoCaptionsScreen()),
      GoRoute(path: '/live', name: 'live',
        builder: (context, state) => const GoLiveScreen()),
      GoRoute(
        path: '/comments/:postId',
        name: 'comments',
        builder: (context, state) =>
            CommentsScreen(postId: state.pathParameters['postId']!),
      ),
      GoRoute(
        path: '/stories/:authorId',
        name: 'stories',
        builder: (context, state) {
          final authorId = state.pathParameters['authorId']!;
          final stories = storiesAsync.valueOrNull ?? const [];
          StoryGroup group;
          try {
            group = stories.firstWhere((g) => g.author.id == authorId);
          } on StateError {
            group = StoryGroup(
              author: UserModel.currentUser,
              stories: const [],
              latestAt: DateTime.now(),
            );
          }
          return StoryViewerScreen(group: group);
        },
      ),
      GoRoute(
        path: '/post-composer',
        name: 'post_composer',
        builder: (context, state) {
          final params = state.extra as PostComposerParams?;
          if (params == null) {
            return const Scaffold(
              body: Center(child: Text('Missing composer params')),
            );
          }
          return PostComposerScreen(
            mediaPath: params.mediaPath,
            kind: params.kind,
          );
        },
      ),
      GoRoute(
        path: '/profile/:userId',
        name: 'profile',
        builder: (context, state) =>
            ProfileScreen(userId: state.pathParameters['userId']),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: StudioColors.canvas,
      body: Center(
        child: Text('Route not found: ${state.uri}',
            style: const TextStyle(color: StudioColors.textPrimary)),
      ),
    ),
  );
});

class PostComposerParams {
  final String mediaPath;
  final PostKind kind;

  const PostComposerParams({required this.mediaPath, required this.kind});
}
