library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../commands/history_engine.dart';
import '../commands/studio_command.dart';
import '../entities/layer.dart';
import '../entities/project.dart';
import '../entities/track.dart';
import '../utils/typedefs.dart';

class StudioSessionState {
  final StudioProject project;
  final HistorySnapshot history;
  final Microseconds playhead;
  final StudioId? selectedLayerId;
  final StudioId? selectedTrackId;
  final bool isPlaying;
  final bool isScrubbing;
  final String? lastUserMessage;

  const StudioSessionState({
    required this.project,
    required this.history,
    required this.playhead,
    this.selectedLayerId,
    this.selectedTrackId,
    this.isPlaying = false,
    this.isScrubbing = false,
    this.lastUserMessage,
  });

  static StudioSessionState initial() => StudioSessionState(
        project: StudioProject.create(id: const Uuid().v4()),
        history: const HistorySnapshot(
          undoStack: [],
          redoStack: [],
          currentIndex: 0,
        ),
        playhead: 0,
      );

  StudioSessionState copyWith({
    StudioProject? project,
    HistorySnapshot? history,
    Microseconds? playhead,
    Object? selectedLayerId = _sentinel,
    Object? selectedTrackId = _sentinel,
    bool? isPlaying,
    bool? isScrubbing,
    Object? lastUserMessage = _sentinel,
  }) {
    return StudioSessionState(
      project: project ?? this.project,
      history: history ?? this.history,
      playhead: playhead ?? this.playhead,
      selectedLayerId: identical(selectedLayerId, _sentinel)
          ? this.selectedLayerId
          : selectedLayerId as StudioId?,
      selectedTrackId: identical(selectedTrackId, _sentinel)
          ? this.selectedTrackId
          : selectedTrackId as StudioId?,
      isPlaying: isPlaying ?? this.isPlaying,
      isScrubbing: isScrubbing ?? this.isScrubbing,
      lastUserMessage: identical(lastUserMessage, _sentinel)
          ? this.lastUserMessage
          : lastUserMessage as String?,
    );
  }
}

const Object _sentinel = Object();

class StudioSessionNotifier
    extends AutoDisposeNotifier<StudioSessionState> {
  late final HistoryEngine _history;

  @override
  StudioSessionState build() {
    _history = HistoryEngine();
    return StudioSessionState.initial();
  }

  void loadProject(StudioProject project) {
    _history.reset();
    state = StudioSessionState(
      project: project,
      history: _history.snapshot(),
      playhead: 0,
    );
  }

  void reset() {
    _history.reset();
    state = StudioSessionState.initial();
  }

  void execute(StudioCommand command) {
    final result = _history.apply(state.project, command);
    state = state.copyWith(
      project: result.project,
      history: _history.snapshot(),
      lastUserMessage: result.userMessage,
    );
  }

  void undo() {
    final result = _history.undo(state.project);
    state = state.copyWith(
      project: result.project,
      history: _history.snapshot(),
      lastUserMessage: result.userMessage,
    );
  }

  void redo() {
    final result = _history.redo(state.project);
    state = state.copyWith(
      project: result.project,
      history: _history.snapshot(),
      lastUserMessage: result.userMessage,
    );
  }

  void selectLayer(StudioId? id) => state = state.copyWith(selectedLayerId: id);
  void selectTrack(StudioId? id) => state = state.copyWith(selectedTrackId: id);

  void setPlayhead(Microseconds t) {
    final clamped = t.clamp(0, state.project.totalDuration);
    state = state.copyWith(playhead: clamped);
  }

  void play() => state = state.copyWith(isPlaying: true);
  void pause() => state = state.copyWith(isPlaying: false);
  void setScrubbing(bool v) => state = state.copyWith(isScrubbing: v);

  void advancePlayhead(Microseconds delta) {
    if (!state.isPlaying) return;
    final next = state.playhead + delta;
    if (next >= state.project.totalDuration) {
      state = state.copyWith(
        playhead: state.project.totalDuration,
        isPlaying: false,
      );
    } else {
      state = state.copyWith(playhead: next);
    }
  }

  StudioLayer? get selectedLayer => state.selectedLayerId == null
      ? null
      : state.project.layerById(state.selectedLayerId!);

  StudioTrack? get selectedTrack => state.selectedTrackId == null
      ? null
      : state.project.trackById(state.selectedTrackId!);
}

final studioSessionProvider = AutoDisposeNotifierProvider<
    StudioSessionNotifier, StudioSessionState>(
  StudioSessionNotifier.new,
);
