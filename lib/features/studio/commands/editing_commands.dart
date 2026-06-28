library;

import 'package:uuid/uuid.dart';

import '../entities/layer.dart';
import '../entities/media_source.dart';
import '../entities/project.dart';
import '../entities/track.dart';
import '../entities/transform.dart';
import '../utils/typedefs.dart';
import 'studio_command.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Track commands
// ─────────────────────────────────────────────────────────────────────────────

class AddTrackCommand implements StudioCommand {
  AddTrackCommand({
    required this.track,
    String? commandId,
  }) : commandId = commandId ?? 'add_track_${track.id}';

  final StudioTrack track;

  @override
  final String commandId;

  @override
  String get label => 'Add track "${track.name}"';

  @override
  CommandResult execute(StudioProject project) {
    if (project.tracks.any((t) => t.id == track.id)) {
      return CommandFailure(project, StateError('Track already exists'), StackTrace.current);
    }
    return CommandSuccess(
      project.copyWith(
        tracks: [...project.tracks, track],
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    return CommandSuccess(
      project.copyWith(
        tracks: project.tracks.where((t) => t.id != track.id).toList(),
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

class RemoveTrackCommand implements StudioCommand {
  RemoveTrackCommand({required this.trackId})
      : commandId = 'remove_track_$trackId';

  final StudioId trackId;

  @override
  final String commandId;

  @override
  String get label => 'Remove track';

  StudioTrack? _removed;
  List<StudioLayer> _removedLayers = const [];

  @override
  CommandResult execute(StudioProject project) {
    final track = project.tracks.firstWhereOrNull((t) => t.id == trackId);
    if (track == null) {
      return CommandFailure(project, StateError('Track not found'), StackTrace.current);
    }
    _removed = track;
    _removedLayers = project.layers.where((l) => l.trackId_ == trackId).toList();
    return CommandSuccess(
      project.copyWith(
        tracks: project.tracks.where((t) => t.id != trackId).toList(),
        layers: project.layers.where((l) => l.trackId_ != trackId).toList(),
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    final removed = _removed;
    if (removed == null) return CommandSuccess(project);
    return CommandSuccess(
      project.copyWith(
        tracks: [...project.tracks, removed],
        layers: [...project.layers, ..._removedLayers],
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Layer commands
// ─────────────────────────────────────────────────────────────────────────────

class AddLayerCommand implements StudioCommand {
  AddLayerCommand({
    required this.layer,
    MediaSource? source,
    String? commandId,
  })  : _source = source,
        commandId = commandId ?? 'add_layer_${layer.layerId}';

  final StudioLayer layer;
  final MediaSource? _source;

  @override
  final String commandId;

  @override
  String get label =>
      'Add ${layer.runtimeType.toString().replaceFirst('Layer', '')}';

  @override
  CommandResult execute(StudioProject project) {
    final sources = _source == null ||
            project.sources.any((s) => s.sourceId == _source!.sourceId)
        ? project.sources
        : [...project.sources, _source!];

    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers, layer],
        sources: sources,
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    return CommandSuccess(
      project.copyWith(
        layers:
            project.layers.where((l) => l.layerId != layer.layerId).toList(),
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

class DeleteLayerCommand implements StudioCommand {
  DeleteLayerCommand({required this.layerId})
      : commandId = 'delete_layer_$layerId';

  final StudioId layerId;

  @override
  final String commandId;

  @override
  String get label => 'Delete layer';

  StudioLayer? _removed;

  @override
  CommandResult execute(StudioProject project) {
    final layer = project.layers.firstWhereOrNull((l) => l.layerId == layerId);
    if (layer == null) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    _removed = layer;
    return CommandSuccess(
      project.copyWith(
        layers: project.layers.where((l) => l.layerId != layerId).toList(),
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    final removed = _removed;
    if (removed == null) return CommandSuccess(project);
    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers, removed],
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

class MoveLayerCommand implements StudioCommand {
  MoveLayerCommand({
    required this.layerId,
    required this.newStart,
    this.newTrackId,
    String? commandId,
  }) : commandId = commandId ?? 'move_layer_$layerId';

  final StudioId layerId;
  final Microseconds newStart;
  final StudioId? newTrackId;

  @override
  final String commandId;

  @override
  bool get isMergeable => true;

  @override
  String get label => 'Move layer';

  Microseconds? _oldStart;
  StudioId? _oldTrackId;

  @override
  CommandResult execute(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    final old = project.layers[idx];
    _oldStart = old.startMicroseconds;
    _oldTrackId = old.trackId_;

    final updated = _replaceLayer(
      old,
      start: newStart,
      trackId: newTrackId ?? old.trackId_,
    );

    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers]..[idx] = updated,
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) return CommandSuccess(project);
    final old = project.layers[idx];
    final restored = _replaceLayer(
      old,
      start: _oldStart ?? old.startMicroseconds,
      trackId: _oldTrackId ?? old.trackId_,
    );
    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers]..[idx] = restored,
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

class TrimClipCommand implements StudioCommand {
  TrimClipCommand({
    required this.layerId,
    required this.newStart,
    required this.newDuration,
    this.newSourceStart,
    String? commandId,
  }) : commandId = commandId ?? 'trim_layer_$layerId';

  final StudioId layerId;
  final Microseconds newStart;
  final Microseconds newDuration;
  final Microseconds? newSourceStart;

  @override
  final String commandId;

  @override
  bool get isMergeable => true;

  @override
  String get label => 'Trim clip';

  Microseconds? _oldStart;
  Microseconds? _oldDuration;
  Microseconds? _oldSourceStart;

  @override
  CommandResult execute(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    final old = project.layers[idx];
    _oldStart = old.startMicroseconds;
    _oldDuration = old.durationMicroseconds;
    _oldSourceStart = old.map(
      video: (l) => l.sourceStart,
      image: (_) => 0,
      text: (_) => 0,
      sticker: (_) => 0,
      effect: (_) => 0,
      audio: (l) => l.sourceStart,
    );

    final updated = _replaceLayer(
      old,
      start: newStart,
      duration: newDuration,
      sourceStart: newSourceStart ?? _oldSourceStart,
    );

    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers]..[idx] = updated,
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) return CommandSuccess(project);
    final old = project.layers[idx];
    final restored = _replaceLayer(
      old,
      start: _oldStart ?? old.startMicroseconds,
      duration: _oldDuration ?? old.durationMicroseconds,
      sourceStart: _oldSourceStart ?? 0,
    );
    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers]..[idx] = restored,
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

class SplitClipCommand implements StudioCommand {
  SplitClipCommand({
    required this.layerId,
    required this.atMicroseconds,
  }) : commandId = 'split_layer_${const Uuid().v4()}';

  final StudioId layerId;
  final Microseconds atMicroseconds;

  @override
  final String commandId;

  @override
  String get label => 'Split clip';

  StudioLayer? _removedSecond;

  @override
  CommandResult execute(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    final original = project.layers[idx];
    final splitOffset = atMicroseconds - original.startMicroseconds;
    if (splitOffset <= 0 || splitOffset >= original.durationMicroseconds) {
      return CommandFailure(
          project, RangeError('Split point out of range'), StackTrace.current);
    }

    final firstDuration = splitOffset;
    final secondDuration = original.durationMicroseconds - splitOffset;
    final secondStart = original.startMicroseconds + firstDuration;

    final firstSourceStart = original.map(
      video: (l) => l.sourceStart,
      image: (_) => 0,
      text: (_) => 0,
      sticker: (_) => 0,
      effect: (_) => 0,
      audio: (l) => l.sourceStart,
    );

    final first = _replaceLayer(
      original,
      duration: firstDuration,
      sourceStart: firstSourceStart,
    );

    final secondId =
        '${original.layerId}_split_${const Uuid().v4().substring(0, 8)}';
    final second = _replaceLayer(
      original,
      id: secondId,
      start: secondStart,
      duration: secondDuration,
      sourceStart: firstSourceStart + firstDuration,
    );

    _removedSecond = second;

    final newLayers = [...project.layers]..[idx] = first;
    newLayers.insert(idx + 1, second);

    return CommandSuccess(
      project.copyWith(layers: newLayers, updatedAt: DateTime.now()),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    if (_removedSecond == null) return CommandSuccess(project);
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) return CommandSuccess(project);
    final first = project.layers[idx];
    final restored = _replaceLayer(
      first,
      duration: first.durationMicroseconds +
          _removedSecond!.durationMicroseconds,
    );
    final newLayers = [...project.layers]
      ..[idx] = restored
      ..removeWhere((l) => l.layerId == _removedSecond!.layerId);

    return CommandSuccess(
      project.copyWith(layers: newLayers, updatedAt: DateTime.now()),
      'Undo: $label',
    );
  }
}

class AddAudioCommand implements StudioCommand {
  AddAudioCommand({
    required this.layer,
    required this.source,
    String? commandId,
  })  : assert(layer is AudioLayer, 'AddAudioCommand requires an AudioLayer'),
        commandId = commandId ?? 'add_audio_${layer.layerId}';

  final StudioLayer layer;
  final MediaSource source;

  @override
  final String commandId;

  @override
  String get label => 'Add audio';

  @override
  CommandResult execute(StudioProject project) =>
      AddLayerCommand(layer: layer, source: source, commandId: commandId)
          .execute(project);

  @override
  CommandResult undo(StudioProject project) =>
      DeleteLayerCommand(layerId: layer.layerId).execute(project);
}

class AddTextCommand implements StudioCommand {
  AddTextCommand({
    required this.layer,
    String? commandId,
  })  : assert(layer is TextLayer, 'AddTextCommand requires a TextLayer'),
        commandId = commandId ?? 'add_text_${layer.layerId}';

  final StudioLayer layer;

  @override
  final String commandId;

  @override
  String get label => 'Add text';

  @override
  CommandResult execute(StudioProject project) =>
      AddLayerCommand(layer: layer, commandId: commandId).execute(project);

  @override
  CommandResult undo(StudioProject project) =>
      DeleteLayerCommand(layerId: layer.layerId).execute(project);
}

class AddStickerCommand implements StudioCommand {
  AddStickerCommand({
    required this.layer,
    String? commandId,
  })  : assert(layer is StickerLayer, 'AddStickerCommand requires a StickerLayer'),
        commandId = commandId ?? 'add_sticker_${layer.layerId}';

  final StudioLayer layer;

  @override
  final String commandId;

  @override
  String get label => 'Add sticker';

  @override
  CommandResult execute(StudioProject project) =>
      AddLayerCommand(layer: layer, commandId: commandId).execute(project);

  @override
  CommandResult undo(StudioProject project) =>
      DeleteLayerCommand(layerId: layer.layerId).execute(project);
}

class ApplyEffectCommand implements StudioCommand {
  ApplyEffectCommand({
    required this.layer,
    String? commandId,
  })  : assert(layer is EffectLayer, 'ApplyEffectCommand requires an EffectLayer'),
        commandId = commandId ?? 'apply_effect_${layer.layerId}';

  final StudioLayer layer;

  @override
  final String commandId;

  @override
  String get label => 'Apply effect';

  @override
  CommandResult execute(StudioProject project) =>
      AddLayerCommand(layer: layer, commandId: commandId).execute(project);

  @override
  CommandResult undo(StudioProject project) =>
      DeleteLayerCommand(layerId: layer.layerId).execute(project);
}

class UpdateLayerTransformCommand implements StudioCommand {
  UpdateLayerTransformCommand({
    required this.layerId,
    required this.newTransform,
    String? commandId,
  }) : commandId = commandId ?? 'update_transform_$layerId';

  final StudioId layerId;
  final StudioTransform newTransform;

  @override
  final String commandId;

  @override
  bool get isMergeable => true;

  @override
  String get label => 'Move / resize';

  StudioTransform? _old;

  @override
  CommandResult execute(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    final old = project.layers[idx];
    _old = _getTransform(old);
    final updated = _replaceLayer(old, transform: newTransform);
    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers]..[idx] = updated,
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) return CommandSuccess(project);
    final old = project.layers[idx];
    final restored =
        _replaceLayer(old, transform: _old ?? StudioTransform.identity);
    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers]..[idx] = restored,
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

class UpdateTextCommand implements StudioCommand {
  UpdateTextCommand({
    required this.layerId,
    required this.newText,
    String? commandId,
  }) : commandId = commandId ?? 'update_text_$layerId';

  final StudioId layerId;
  final String newText;

  @override
  final String commandId;

  @override
  bool get isMergeable => true;

  @override
  String get label => 'Edit text';

  String? _oldText;

  @override
  CommandResult execute(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    final old = project.layers[idx];
    if (old is! TextLayer) {
      return CommandFailure(
          project, StateError('Layer is not a text layer'), StackTrace.current);
    }
    _oldText = old.text;
    final updated = old.copyWith(text: newText);
    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers]..[idx] = updated,
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) return CommandSuccess(project);
    final old = project.layers[idx];
    if (old is! TextLayer) return CommandSuccess(project);
    final restored = old.copyWith(text: _oldText ?? old.text);
    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers]..[idx] = restored,
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

class UpdateVolumeCommand implements StudioCommand {
  UpdateVolumeCommand({
    required this.layerId,
    required this.newVolume,
    String? commandId,
  }) : commandId = commandId ?? 'update_volume_$layerId';

  final StudioId layerId;
  final double newVolume;

  @override
  final String commandId;

  @override
  bool get isMergeable => true;

  @override
  String get label => 'Adjust volume';

  double? _oldVolume;

  @override
  CommandResult execute(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    final old = project.layers[idx];
    if (old is VideoLayer) {
      _oldVolume = old.volume;
      final updated = old.copyWith(volume: newVolume);
      return CommandSuccess(
        project.copyWith(
          layers: [...project.layers]..[idx] = updated,
          updatedAt: DateTime.now(),
        ),
        label,
      );
    } else if (old is AudioLayer) {
      _oldVolume = old.volume;
      final updated = old.copyWith(volume: newVolume);
      return CommandSuccess(
        project.copyWith(
          layers: [...project.layers]..[idx] = updated,
          updatedAt: DateTime.now(),
        ),
        label,
      );
    }
    return CommandFailure(
        project, StateError('Layer has no volume'), StackTrace.current);
  }

  @override
  CommandResult undo(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) return CommandSuccess(project);
    final old = project.layers[idx];
    if (old is VideoLayer) {
      final restored = old.copyWith(volume: _oldVolume ?? old.volume);
      return CommandSuccess(
        project.copyWith(
          layers: [...project.layers]..[idx] = restored,
          updatedAt: DateTime.now(),
        ),
        'Undo: $label',
      );
    } else if (old is AudioLayer) {
      final restored = old.copyWith(volume: _oldVolume ?? old.volume);
      return CommandSuccess(
        project.copyWith(
          layers: [...project.layers]..[idx] = restored,
          updatedAt: DateTime.now(),
        ),
        'Undo: $label',
      );
    }
    return CommandSuccess(project);
  }
}

class UpdateSpeedCommand implements StudioCommand {
  UpdateSpeedCommand({
    required this.layerId,
    required this.newSpeed,
    String? commandId,
  }) : commandId = commandId ?? 'update_speed_$layerId';

  final StudioId layerId;
  final double newSpeed;

  @override
  final String commandId;

  @override
  bool get isMergeable => true;

  @override
  String get label => 'Adjust speed';

  double? _oldSpeed;

  @override
  CommandResult execute(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    final old = project.layers[idx];
    if (old is VideoLayer) {
      _oldSpeed = old.speed;
      final updated = old.copyWith(speed: newSpeed);
      return CommandSuccess(
        project.copyWith(
          layers: [...project.layers]..[idx] = updated,
          updatedAt: DateTime.now(),
        ),
        label,
      );
    } else if (old is AudioLayer) {
      _oldSpeed = old.speed;
      final updated = old.copyWith(speed: newSpeed);
      return CommandSuccess(
        project.copyWith(
          layers: [...project.layers]..[idx] = updated,
          updatedAt: DateTime.now(),
        ),
        label,
      );
    }
    return CommandFailure(
        project, StateError('Layer has no speed'), StackTrace.current);
  }

  @override
  CommandResult undo(StudioProject project) {
    final idx = project.layers.indexWhere((l) => l.layerId == layerId);
    if (idx == -1) return CommandSuccess(project);
    final old = project.layers[idx];
    if (old is VideoLayer) {
      final restored = old.copyWith(speed: _oldSpeed ?? old.speed);
      return CommandSuccess(
        project.copyWith(
          layers: [...project.layers]..[idx] = restored,
          updatedAt: DateTime.now(),
        ),
        'Undo: $label',
      );
    } else if (old is AudioLayer) {
      final restored = old.copyWith(speed: _oldSpeed ?? old.speed);
      return CommandSuccess(
        project.copyWith(
          layers: [...project.layers]..[idx] = restored,
          updatedAt: DateTime.now(),
        ),
        'Undo: $label',
      );
    }
    return CommandSuccess(project);
  }
}

class ReorderLayerCommand implements StudioCommand {
  ReorderLayerCommand({
    required this.layerId,
    required this.newIndex,
    String? commandId,
  }) : commandId = commandId ?? 'reorder_layer_$layerId';

  final StudioId layerId;
  final int newIndex;

  @override
  final String commandId;

  @override
  String get label => 'Reorder layer';

  int? _oldIndex;

  @override
  CommandResult execute(StudioProject project) {
    final oldIndex =
        project.layers.indexWhere((l) => l.layerId == layerId);
    if (oldIndex == -1) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    _oldIndex = oldIndex;
    final layers = [...project.layers];
    final layer = layers.removeAt(oldIndex);
    layers.insert(newIndex.clamp(0, layers.length), layer);
    return CommandSuccess(
      project.copyWith(layers: layers, updatedAt: DateTime.now()),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    if (_oldIndex == null) return CommandSuccess(project);
    final currentIndex =
        project.layers.indexWhere((l) => l.layerId == layerId);
    if (currentIndex == -1) return CommandSuccess(project);
    final layers = [...project.layers];
    final layer = layers.removeAt(currentIndex);
    layers.insert(_oldIndex!.clamp(0, layers.length), layer);
    return CommandSuccess(
      project.copyWith(layers: layers, updatedAt: DateTime.now()),
      'Undo: $label',
    );
  }
}

class DuplicateLayerCommand implements StudioCommand {
  DuplicateLayerCommand({
    required this.layerId,
    String? commandId,
  }) : commandId = commandId ?? 'duplicate_layer_${const Uuid().v4()}';

  final StudioId layerId;

  @override
  final String commandId;

  @override
  String get label => 'Duplicate layer';

  StudioLayer? _duplicate;

  @override
  CommandResult execute(StudioProject project) {
    final original =
        project.layers.firstWhereOrNull((l) => l.layerId == layerId);
    if (original == null) {
      return CommandFailure(
          project, StateError('Layer not found'), StackTrace.current);
    }
    final newId = '${layerId}_copy_${const Uuid().v4().substring(0, 8)}';
    final duplicate = _replaceLayer(
      original,
      id: newId,
      start: original.startMicroseconds + original.durationMicroseconds,
    );
    _duplicate = duplicate;
    return CommandSuccess(
      project.copyWith(
        layers: [...project.layers, duplicate],
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    final dup = _duplicate;
    if (dup == null) return CommandSuccess(project);
    return CommandSuccess(
      project.copyWith(
        layers: project.layers.where((l) => l.layerId != dup.layerId).toList(),
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Project-level commands
// ─────────────────────────────────────────────────────────────────────────────

class UpdateProjectSettingsCommand implements StudioCommand {
  UpdateProjectSettingsCommand({
    required this.name,
    this.aspectRatio,
    this.targetHeight,
    this.fps,
    String? commandId,
  }) : commandId = commandId ?? 'update_project_settings';

  final String name;
  final AspectRatioPreset? aspectRatio;
  final int? targetHeight;
  final int? fps;

  @override
  final String commandId;

  @override
  String get label => 'Update project settings';

  String? _oldName;
  AspectRatioPreset? _oldAspectRatio;
  int? _oldTargetHeight;
  int? _oldFps;

  @override
  CommandResult execute(StudioProject project) {
    _oldName = project.name;
    _oldAspectRatio = project.aspectRatio;
    _oldTargetHeight = project.targetHeight;
    _oldFps = project.fps;

    return CommandSuccess(
      project.copyWith(
        name: name,
        aspectRatio: aspectRatio ?? project.aspectRatio,
        targetHeight: targetHeight ?? project.targetHeight,
        fps: fps ?? project.fps,
        updatedAt: DateTime.now(),
      ),
      label,
    );
  }

  @override
  CommandResult undo(StudioProject project) {
    return CommandSuccess(
      project.copyWith(
        name: _oldName ?? project.name,
        aspectRatio: _oldAspectRatio ?? project.aspectRatio,
        targetHeight: _oldTargetHeight ?? project.targetHeight,
        fps: _oldFps ?? project.fps,
        updatedAt: DateTime.now(),
      ),
      'Undo: $label',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Internal helpers
// ─────────────────────────────────────────────────────────────────────────────

StudioLayer _replaceLayer(
  StudioLayer layer, {
  StudioId? id,
  StudioId? trackId,
  Microseconds? start,
  Microseconds? duration,
  Microseconds? sourceStart,
  StudioTransform? transform,
}) {
  return layer.map(
    video: (l) => l.copyWith(
      id: id ?? l.id,
      trackId: trackId ?? l.trackId,
      start: start ?? l.start,
      duration: duration ?? l.duration,
      sourceStart: sourceStart ?? l.sourceStart,
      transform: transform ?? l.transform,
    ),
    image: (l) => l.copyWith(
      id: id ?? l.id,
      trackId: trackId ?? l.trackId,
      start: start ?? l.start,
      duration: duration ?? l.duration,
      transform: transform ?? l.transform,
    ),
    text: (l) => l.copyWith(
      id: id ?? l.id,
      trackId: trackId ?? l.trackId,
      start: start ?? l.start,
      duration: duration ?? l.duration,
      transform: transform ?? l.transform,
    ),
    sticker: (l) => l.copyWith(
      id: id ?? l.id,
      trackId: trackId ?? l.trackId,
      start: start ?? l.start,
      duration: duration ?? l.duration,
      transform: transform ?? l.transform,
    ),
    effect: (l) => l.copyWith(
      id: id ?? l.id,
      trackId: trackId ?? l.trackId,
      start: start ?? l.start,
      duration: duration ?? l.duration,
      transform: transform ?? l.transform,
    ),
    audio: (l) => l.copyWith(
      id: id ?? l.id,
      trackId: trackId ?? l.trackId,
      start: start ?? l.start,
      duration: duration ?? l.duration,
      sourceStart: sourceStart ?? l.sourceStart,
    ),
  );
}

StudioTransform _getTransform(StudioLayer layer) {
  return layer.map(
    video: (l) => l.transform,
    image: (l) => l.transform,
    text: (l) => l.transform,
    sticker: (l) => l.transform,
    effect: (l) => l.transform,
    audio: (_) => StudioTransform.identity,
  );
}
