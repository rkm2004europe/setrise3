enum MsgType { text, image, video, audio, file, location, sticker, poll }
enum MsgStatus { sending, sent, delivered, read }

class Reaction {
  final String emoji;
  int count;
  bool mine;
  Reaction({required this.emoji, this.count = 1, this.mine = false});
}

class Message {
  final String id;
  final String senderId;
  final MsgType type;
  final String? text;
  final String? mediaEmoji;
  final String? fileName;
  final String? fileExt;
  final int? fileSize;
  final int? audioDuration;
  final String? locationName;
  final Message? replyTo;
  final MsgStatus status;
  final DateTime createdAt;
  final bool isDeleted;
  final bool isStarred;
  final List<Reaction> reactions;

  Message({
    required this.id,
    required this.senderId,
    required this.type,
    this.text,
    this.mediaEmoji,
    this.fileName,
    this.fileExt,
    this.fileSize,
    this.audioDuration,
    this.locationName,
    this.replyTo,
    this.status = MsgStatus.sent,
    required this.createdAt,
    this.isDeleted = false,
    this.isStarred = false,
    this.reactions = const [],
  });

  bool get isMe => senderId == 'me';

  Message copyWith({
    String? id,
    String? senderId,
    MsgType? type,
    String? text,
    String? mediaEmoji,
    String? fileName,
    String? fileExt,
    int? fileSize,
    int? audioDuration,
    String? locationName,
    Message? replyTo,
    MsgStatus? status,
    DateTime? createdAt,
    bool? isDeleted,
    bool? isStarred,
    List<Reaction>? reactions,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      type: type ?? this.type,
      text: text ?? this.text,
      mediaEmoji: mediaEmoji ?? this.mediaEmoji,
      fileName: fileName ?? this.fileName,
      fileExt: fileExt ?? this.fileExt,
      fileSize: fileSize ?? this.fileSize,
      audioDuration: audioDuration ?? this.audioDuration,
      locationName: locationName ?? this.locationName,
      replyTo: replyTo ?? this.replyTo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isStarred: isStarred ?? this.isStarred,
      reactions: reactions ?? this.reactions,
    );
  }

  String get fileSizeText {
    if (fileSize == null) return '';
    if (fileSize! < 1024) return '${fileSize} B';
    if (fileSize! < 1024 * 1024) return '${(fileSize! / 1024).toStringAsFixed(1)} KB';
    return '${(fileSize! / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

enum ConvType { friend, group, channel, broadcast }

class User {
  final String id;
  final String name;
  final String username;
  final String avatar;
  final bool isOnline;
  final String? lastSeen;
  final ConvType type;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
    this.isOnline = false,
    this.lastSeen,
    this.type = ConvType.friend,
  });

  String get lastSeenText => isOnline ? 'متصل الآن' : (lastSeen ?? 'منذ فترة');
}

class Conversation {
  final String id;
  final User user;
  final ConvType type;
  final String? groupName;
  final String? groupAvatar;
  final int? membersCount;
  final Message? lastMessage;
  final int unread;
  final bool isArchived;
  final bool isMuted;
  final DateTime updatedAt;

  Conversation({
    required this.id,
    required this.user,
    required this.type,
    this.groupName,
    this.groupAvatar,
    this.membersCount,
    this.lastMessage,
    this.unread = 0,
    this.isArchived = false,
    this.isMuted = false,
    required this.updatedAt,
  });

  String get displayName => groupName ?? user.name;
  String get displayAvatar => groupAvatar ?? user.avatar;
  bool get isGroup => type == ConvType.group;
  bool get isChannel => type == ConvType.channel;
}
