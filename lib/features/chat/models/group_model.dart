enum MemberRole { admin, moderator, member }

class GroupMember {
  final String userId;
  final String name;
  final String avatar;
  MemberRole role;
  final DateTime joinedAt;

  GroupMember({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.role,
    required this.joinedAt,
  });
}

class GroupModel {
  final String id;
  final String name;
  final String avatar;
  final String description;
  final List<GroupMember> members;
  final bool isPrivate;
  final String? inviteLink;

  GroupModel({
    required this.id,
    required this.name,
    required this.avatar,
    this.description = '',
    required this.members,
    this.isPrivate = false,
    this.inviteLink,
  });
}
