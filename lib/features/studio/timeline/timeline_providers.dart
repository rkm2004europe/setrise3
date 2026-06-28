library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/studio_session.dart';
import 'timeline_engine.dart';

final timelineEngineProvider = Provider<TimelineEngine>((ref) {
  return TimelineEngine();
});

final timelineSnapLinesProvider = Provider<List<int>>((ref) {
  final session = ref.watch(studioSessionProvider);
  final project = session.project;
  final engine = ref.watch(timelineEngineProvider);
  return engine.snapLines(project);
});

final activeLayersAtPlayheadProvider = Provider<List<dynamic>>((ref) {
  final session = ref.watch(studioSessionProvider);
  final engine = ref.watch(timelineEngineProvider);
  return engine.activeLayersAt(session.project, session.playhead);
});
