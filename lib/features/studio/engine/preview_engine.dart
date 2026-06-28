library;

import 'dart:async';

import '../composition/composition_engine.dart';
import '../entities/project.dart';
import '../utils/typedefs.dart';

abstract interface class AudioPlaybackAdapter {
  Future<void> play(AudioMixPlan plan, Microseconds t);
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Microseconds t);
  Stream<double> get amplitudeStream;
}

class PreviewConfig {
  final int uiRefreshHz;
  final int simTickHz;
  final bool audioEnabled;

  const PreviewConfig({
    this.uiRefreshHz = 30,
    this.simTickHz = 60,
    this.audioEnabled = true,
  });
}

class PreviewEngine {
  PreviewEngine({
    required this.composition,
    required this.config,
    AudioPlaybackAdapter? audio,
  }) : _audio = audio;

  final CompositionEngine composition;
  final PreviewConfig config;
  final AudioPlaybackAdapter? _audio;

  Timer? _simTimer;
  Timer? _uiTimer;
  DateTime _lastSim = DateTime.now();

  final StreamController<CompositionFrame> _frameController =
      StreamController<CompositionFrame>.broadcast();
  Stream<CompositionFrame> get frames => _frameController.stream;

  final StreamController<Microseconds> _playheadController =
      StreamController<Microseconds>.broadcast();
  Stream<Microseconds> get playhead => _playheadController.stream;

  StudioProject? _project;
  Microseconds _playhead = 0;
  bool _isPlaying = false;
  bool _isScrubbing = false;

  bool get isPlaying => _isPlaying;
  Microseconds get currentPlayhead => _playhead;

  void attach(StudioProject project) {
    _project = project;
    _playhead = 0;
  }

  void detach() {
    stop();
    _project = null;
  }

  Future<void> play() async {
    if (_project == null || _isPlaying) return;
    _isPlaying = true;
    _lastSim = DateTime.now();

    if (config.audioEnabled && _audio != null) {
      final mix = composition.audioMixAt(_project!, _playhead);
      await _audio!.play(mix, _playhead);
    }

    _simTimer?.cancel();
    _simTimer = Timer.periodic(
      Duration(microseconds: 1000000 ~/ config.simTickHz),
      _onSimTick,
    );

    _uiTimer?.cancel();
    _uiTimer = Timer.periodic(
      Duration(microseconds: 1000000 ~/ config.uiRefreshHz),
      _onUiTick,
    );
  }

  Future<void> pause() async {
    _isPlaying = false;
    _simTimer?.cancel();
    _uiTimer?.cancel();
    if (_audio != null) await _audio!.pause();
  }

  Future<void> stop() async {
    await pause();
    _playhead = 0;
    if (_audio != null) await _audio!.stop();
    _playheadController.add(_playhead);
  }

  Future<void> seek(Microseconds t) async {
    final clamped = t.clamp(0, _project?.totalDuration ?? 0);
    _playhead = clamped;
    _playheadController.add(_playhead);
    if (_audio != null) await _audio!.seek(clamped);
    _emitFrame();
  }

  void setScrubbing(bool v) {
    _isScrubbing = v;
    if (v && _isPlaying) {
      pause();
    }
  }

  void _onSimTick(Timer _) {
    if (!_isPlaying || _project == null) return;
    final now = DateTime.now();
    final delta = now.difference(_lastSim).inMicroseconds;
    _lastSim = now;

    _playhead = (_playhead + delta).clamp(0, _project!.totalDuration);

    if (_playhead >= _project!.totalDuration) {
      pause();
    }
  }

  void _onUiTick(Timer _) {
    if (_project == null) return;
    _playheadController.add(_playhead);
    _emitFrame();
  }

  void _emitFrame() {
    if (_project == null) return;
    final frame = composition.compose(_project!, _playhead);
    _frameController.add(frame);
  }

  void dispose() {
    _simTimer?.cancel();
    _uiTimer?.cancel();
    _frameController.close();
    _playheadController.close();
  }
}
