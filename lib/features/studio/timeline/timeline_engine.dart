library;

import '../entities/layer.dart';
import '../entities/project.dart';
import '../entities/track.dart';
import '../utils/typedefs.dart';

const Microseconds kDefaultSnapMicros = 33333;

class SnapResult {
  final Microseconds time;
  final SnapTarget target;

  const SnapResult(this.time, this.target);
}

enum SnapTarget { none, playhead, clipStart, clipEnd, trackStart, trackEnd }

class TimelineEngine {
  TimelineEngine({
    this.snapEnabled = true,
    this.snapThreshold = kDefaultSnapMicros * 4,
  });

  final bool snapEnabled;
  final Microseconds snapThreshold;

  Microseconds durationOf(StudioProject project) => project.totalDuration;

  List<StudioLayer> activeLayersAt(StudioProject project, Microseconds time) {
    final layers = project.layers.where((l) => l.isActiveAt(time)).toList();
    layers.sort((a, b) {
      final ta = project.trackById(a.trackId_);
      final tb = project.trackById(b.trackId_);
      return (ta?.z ?? 0).compareTo(tb?.z ?? 0);
    });
    return layers;
  }

  SnapResult snap(
    StudioProject project, {
    required Microseconds candidate,
    Microseconds? playhead,
    StudioId? ignoreLayerId,
  }) {
    if (!snapEnabled) return SnapResult(candidate, SnapTarget.none);

    final points = <Microseconds>[];

    if (playhead != null) points.add(playhead);

    for (final l in project.layers) {
      if (l.layerId == ignoreLayerId) continue;
      points.add(l.startMicroseconds);
      points.add(l.endMicroseconds);
    }

    points.add(0);

    Microseconds? best;
    SnapTarget bestTarget = SnapTarget.none;
    Microseconds bestDelta = snapThreshold;

    for (final p in points) {
      final delta = (candidate - p).abs();
      if (delta < bestDelta) {
        bestDelta = delta;
        best = p;
        if (playhead != null && p == playhead) {
          bestTarget = SnapTarget.playhead;
        } else {
          bestTarget = SnapTarget.clipStart;
        }
      }
    }

    if (best == null) return SnapResult(candidate, SnapTarget.none);
    return SnapResult(best!, bestTarget);
  }

  List<StudioLayer> overlapsWith(StudioProject project, StudioLayer layer) {
    return project.layers.where((other) {
      if (other.layerId == layer.layerId) return false;
      if (other.trackId_ == layer.trackId_) return false;
      final aStart = layer.startMicroseconds;
      final aEnd = layer.endMicroseconds;
      final bStart = other.startMicroseconds;
      final bEnd = other.endMicroseconds;
      return aStart < bEnd && bStart < aEnd;
    }).toList();
  }

  Microseconds? findFreeSlot(
    StudioProject project, {
    required StudioId trackId,
    required Microseconds duration,
    Microseconds earliestStart = 0,
  }) {
    final layersOnTrack = project.layers
        .where((l) => l.trackId_ == trackId)
        .toList()
      ..sort((a, b) => a.startMicroseconds.compareTo(b.startMicroseconds));

    var cursor = earliestStart;
    for (final layer in layersOnTrack) {
      if (layer.endMicroseconds <= cursor) continue;
      if (layer.startMicroseconds >= cursor + duration) {
        return cursor;
      }
      cursor = layer.endMicroseconds;
    }
    return cursor;
  }

  TrackKind suggestTrackKindFor(StudioLayer layer) {
    return layer.map(
      video: (_) => TrackKind.video,
      image: (_) => TrackKind.image,
      text: (_) => TrackKind.text,
      sticker: (_) => TrackKind.sticker,
      effect: (_) => TrackKind.effect,
      audio: (l) => TrackKind.music,
    );
  }

  Microseconds clampStart(
    StudioProject project,
    Microseconds candidate,
    Microseconds duration,
  ) {
    if (candidate < 0) return 0;
    final maxStart = project.totalDuration - duration;
    if (maxStart < 0) return 0;
    if (candidate > maxStart) return maxStart;
    return candidate;
  }

  List<Microseconds> snapLines(StudioProject project,
      {Microseconds? playhead}) {
    final points = <Microseconds>{};
    if (playhead != null) points.add(playhead);
    for (final l in project.layers) {
      points.add(l.startMicroseconds);
      points.add(l.endMicroseconds);
    }
    points.add(0);
    points.add(project.totalDuration);
    return points.toList()..sort();
  }
}
