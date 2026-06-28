library;

import 'dart:collection';

import '../entities/project.dart';
import 'studio_command.dart';

class HistorySnapshot {
  final List<StudioCommand> undoStack;
  final List<StudioCommand> redoStack;
  final int currentIndex;

  const HistorySnapshot({
    required this.undoStack,
    required this.redoStack,
    required this.currentIndex,
  });

  bool get canUndo => undoStack.isNotEmpty;
  bool get canRedo => redoStack.isNotEmpty;
}

class HistoryEngine {
  HistoryEngine({this.maxSize = 100});

  final int maxSize;
  final Queue<StudioCommand> _undo = Queue();
  final Queue<StudioCommand> _redo = Queue();

  ExecutionResult apply(StudioProject project, StudioCommand command) {
    final result = command.execute(project);

    if (result is CommandFailure) {
      return ExecutionResult(
        project: project,
        success: false,
        userMessage: result.userMessage,
      );
    }

    if (command.isMergeable && _undo.isNotEmpty && _undo.last.runtimeType == command.runtimeType) {
      _undo.removeLast();
    } else {
      _redo.clear();
    }
    _undo.add(command);
    _trim();

    return ExecutionResult(
      project: result.project,
      success: true,
      userMessage: result.userMessage,
    );
  }

  ExecutionResult undo(StudioProject project) {
    if (_undo.isEmpty) {
      return ExecutionResult(project: project, success: false);
    }
    final command = _undo.removeLast();
    final result = command.undo(project);
    if (result is CommandFailure) {
      _undo.add(command);
      return ExecutionResult(project: project, success: false, userMessage: result.userMessage);
    }
    _redo.add(command);
    return ExecutionResult(
      project: result.project,
      success: true,
      userMessage: result.userMessage ?? 'Undo: ${command.label}',
    );
  }

  ExecutionResult redo(StudioProject project) {
    if (_redo.isEmpty) {
      return ExecutionResult(project: project, success: false);
    }
    final command = _redo.removeLast();
    final result = command.execute(project);
    if (result is CommandFailure) {
      _redo.add(command);
      return ExecutionResult(project: project, success: false, userMessage: result.userMessage);
    }
    _undo.add(command);
    _trim();
    return ExecutionResult(
      project: result.project,
      success: true,
      userMessage: result.userMessage ?? 'Redo: ${command.label}',
    );
  }

  void reset() {
    _undo.clear();
    _redo.clear();
  }

  HistorySnapshot snapshot() => HistorySnapshot(
        undoStack: _undo.toList(),
        redoStack: _redo.toList(),
        currentIndex: _undo.length,
      );

  void _trim() {
    while (_undo.length > maxSize) {
      _undo.removeFirst();
    }
  }
}

class ExecutionResult {
  final StudioProject project;
  final bool success;
  final String? userMessage;

  const ExecutionResult({
    required this.project,
    required this.success,
    this.userMessage,
  });
}
