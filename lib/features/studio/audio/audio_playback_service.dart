library;

import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '../composition/composition_engine.dart';
import '../utils/typedefs.dart';

/// Implements [AudioPlaybackAdapter] using `just_audio`.
class AudioPlaybackService implements AudioPlaybackAdapter {
  AudioPlaybackService();

  final AudioPlayer _player = AudioPlayer();

  @override
  final StreamController<double> _amplitudeController =
      StreamController<double>.broadcast();
  @override
  Stream<double> get amplitudeStream => _amplitudeController.stream;

  AudioMixPlan? _currentPlan;
  bool _isInitialised = false;

  Future<void> ensureInitialised() async {
    if (_isInitialised) return;
    await _player.setLoopMode(LoopMode.off);
    _isInitialised = true;
  }

  @override
  Future<void> play(AudioMixPlan plan, Microseconds t) async {
    await ensureInitialised();
    _currentPlan = plan;
    if (plan.items.isEmpty) {
      await _player.pause();
      return;
    }

    final primary = plan.items.first;
    try {
      await _player.setUrl(primary.sourcePath);
      await _player.setLoopMode(primary.loop ? LoopMode.one : LoopMode.off);
      await _player.setVolume(primary.volume);
      await _player.seek(Duration(microseconds: primary.sourceTimeMicros));
      await _player.play();
    } on PlayerException catch (e) {
      _amplitudeController.addError(e);
    }
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Microseconds t) async {
    final plan = _currentPlan;
    if (plan == null || plan.items.isEmpty) return;
    final primary = plan.items.first;
    final target = (t + primary.sourceTimeMicros).clamp(
      0,
      _player.duration?.inMicroseconds ?? t,
    );
    await _player.seek(Duration(microseconds: target));
  }

  Future<void> dispose() async {
    await _player.dispose();
    await _amplitudeController.close();
  }
}
