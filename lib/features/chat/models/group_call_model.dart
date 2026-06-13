class GroupCallModel {
  final String id;
  final String groupId;
  final String groupName;
  final List<String> participantIds;
  final bool isActive;

  GroupCallModel({
    required this.id,
    required this.groupId,
    required this.groupName,
    required this.participantIds,
    this.isActive = true,
  });
}
