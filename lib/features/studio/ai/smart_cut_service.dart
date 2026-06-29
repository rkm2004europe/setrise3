/// Smart Cut service — automatic silence detection + beat snapping.
///
/// Two killer features for pro editing:
///
/// 1. **Smart silence removal**:
///    Analyse a video's audio, find all silences > N ms, and generate a
///    command that splits the clip at silence boundaries and removes them.
///    Result: a punchier, faster-paced video with no awkward gaps.
///
/// 2. **Beat snapping**:
///    Analyse the project's music track for beats (BPM), then snap clip
///    boundaries to the nearest beat. Result: a music-video-style edit
///    where every cut lands on the beat.
library;

import 'dart:io';
import 'dart:isolate';

import 'package:audio_analyzer/audio_analyzer.dart';

import '../entities/layer.dart';
import '../entities/project.dart';
import '../utils/typedefs.dart';

class SmartCutService {
  SmartCutService({this.silenceThreshold = 0.05, this.minSilenceMs = 500});

  /// RMS amplitude below which a frame is considered "silent" (~-26 dB).
  final double silenceThreshold;

  /// Minimum silence duration to trigger a cut point.
  final int minSilenceMs;

  /// Detect all silence regions in [audioPath].
  ///
  /// Returns a list of (start, end) pairs in microseconds.
  Future<List<(Microseconds, Microseconds)>> detectSilences(
      String audioPath) async {
    return compute(_detectSilencesWorker, (
      path: audioPath,
      threshold: silenceThreshold,
      minSilenceMs: minSilenceMs,
    ));
  }

  /// Suggest split points for [videoLayer] based on its audio's silences.
  ///
  /// Returns a list of microseconds (relative to the project timeline)
  /// where the user might want to split the clip.
  Future<List<Microseconds>> suggestSplitPoints(
    StudioProject project,
    VideoLayer videoLayer,
  ) async {
    final source = videoLayer.source; // ✅ FIX: direct access
    final path = source.mapOrNull(file: (s) => s.path);
    if (path == null) return const [];

    final silences = await detectSilences(path);
    return silences
        .map((s) => videoLayer.start + s.$1)
        .where((t) =>
            t > videoLayer.start && t < videoLayer.endMicroseconds)
        .toList();
  }

  /// Detect the BPM (beats per minute) of an audio file.
  ///
  /// Uses a simple energy-based beat detector: compute the amplitude
  /// envelope, find peaks above a moving average, count peaks per second.
  Future<int> detectBpm(String audioPath) async {
    final amplitudes =
        await AudioAnalyzer.extractAmplitudes(audioPath, 1000);
    if (amplitudes.length < 10) return 120; // default fallback

    // Compute moving average.
    const windowSize = 10;
    final movingAvg = List<double>.filled(amplitudes.length, 0);
    for (var i = 0; i < amplitudes.length; i++) {
      final start = (i - windowSize).clamp(0, amplitudes.length - 1);
      final end = (i + windowSize).clamp(0, amplitudes.length - 1);
      final slice = amplitudes.sublist(start, end + 1);
      movingAvg[i] = slice.reduce((a, b) => a + b) / slice.length;
    }

    // Find peaks: amplitudes that exceed 1.5x the moving average.
    final peaks = <int>[];
    for (var i = 1; i < amplitudes.length - 1; i++) {
      if (amplitudes[i] > movingAvg[i] * 1.5 &&
          amplitudes[i] > amplitudes[i - 1] &&
          amplitudes[i] > amplitudes[i + 1]) {
        peaks.add(i);
      }
    }

    if (peaks.length < 2) return 120;

    // Compute average inter-peak interval (in ms).
    final totalMs = (peaks.last - peaks.first) * 1000;
    final intervalMs = totalMs / (peaks.length - 1);
    final bpm = (60000 / intervalMs).round();

    // Sanity: BPM should be in 60..200 range.
    if (bpm < 60) return bpm * 2;
    if (bpm > 200) return bpm ~/ 2;
    return bpm;
  }

  /// Suggest beat-aligned split points for a video layer based on the
  /// project's music BPM.
  ///
  /// Returns microseconds (project-relative) where the user might want to
  /// cut to match the music's beat.
  List<Microseconds> beatSplitPoints({
    required int bpm,
    required Microseconds start,
    required Microseconds end,
    Microseconds offset = 0,
  }) {
    final beatIntervalMicros = (60 / bpm * 1000000).round();
    final points = <Microseconds>[];
    var cursor = start + offset;
    while (cursor < end) {
      if (cursor > start) points.add(cursor);
      cursor += beatIntervalMicros;
    }
    return points;
  }
}

// ── Isolate worker for silence detection ──────────────────────────────────
//
// Must be a top-level function so it can be spawned in an isolate.

Future<List<(Microseconds, Microseconds)>> _detectSilencesWorker(
  ({String path, double threshold, int minSilenceMs}) args,
) async {
  final amplitudes =
      await AudioAnalyzer.extractAmplitudes(args.path, 1000);
  final silences = <(Microseconds, Microseconds)>[];
  var silenceStart = -1;

  for (var i = 0; i < amplitudes.length; i++) {
    if (amplitudes[i] < args.threshold) {
      if (silenceStart == -1) silenceStart = i;
    } else {
      if (silenceStart != -1) {
        final silenceMs = (i - silenceStart) * 1000;
        if (silenceMs >= args.minSilenceMs) {
          silences.add((silenceStart * 1000000, i * 1000000));
        }
      }
      silenceStart = -1;
    }
  }

  // Handle trailing silence.
  if (silenceStart != -1) {
    final silenceMs = (amplitudes.length - silenceStart) * 1000;
    if (silenceMs >= args.minSilenceMs) {
      silences.add(
          (silenceStart * 1000000, amplitudes.length * 1000000));
    }
  }

  return silences;
}
