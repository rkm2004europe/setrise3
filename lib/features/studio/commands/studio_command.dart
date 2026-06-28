library;

import '../entities/project.dart';

sealed class CommandResult {
  final StudioProject project;
  final String? userMessage;

  const CommandResult(this.project, this.userMessage);
}

class CommandSuccess extends CommandResult {
  const CommandSuccess(super.project, [super.userMessage]);
}

class CommandFailure extends CommandResult {
  final Object error;
  final StackTrace stackTrace;

  const CommandFailure(
    super.project,
    this.error,
    this.stackTrace, [
    super.userMessage,
  ]);
}

abstract interface class StudioCommand {
  String get commandId;
  String get label;
  bool get isMergeable => false;

  CommandResult execute(StudioProject project);
  CommandResult undo(StudioProject project);
}

class MacroCommand implements StudioCommand {
  @override
  final String commandId;
  @override
  final String label;
  final List<StudioCommand> commands;

  MacroCommand({
    required this.commandId,
    required this.label,
    required this.commands,
  });

  @override
  CommandResult execute(StudioProject project) {
    var current = project;
    for (final cmd in commands) {
      final r = cmd.execute(current);
      if (r is CommandFailure) return r;
      current = r.project;
    }
    return CommandSuccess(current);
  }

  @override
  CommandResult undo(StudioProject project) {
    var current = project;
    for (final cmd in commands.reversed) {
      final r = cmd.undo(current);
      if (r is CommandFailure) return r;
      current = r.project;
    }
    return CommandSuccess(current);
  }
}
