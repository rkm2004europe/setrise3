class BotModel {
  final String id;
  final String name;
  final String avatar;
  final String description;
  final bool isActive;
  final List<String> commands;

  BotModel({
    required this.id,
    required this.name,
    required this.avatar,
    this.description = '',
    this.isActive = true,
    this.commands = const [],
  });
}
