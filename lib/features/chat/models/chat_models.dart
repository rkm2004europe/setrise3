// lib/features/chat/models/chat_models.dart

enum MessageType { text, image, video, audio, file, location, sticker, deleted }
enum MessageStatus { sending, sent, delivered, read }

class MessageReaction {
  final String emoji;
  final int count;
  final bool isMyReaction;
  const MessageReaction({
    required this.emoji, required this.count, this.isMyReaction = false});
}

class ChatMessage {
  final String id;
  final String senderId;
  final MessageType type;
  final String? text;
  final ChatMessage? replyTo;
  final MessageStatus status;
  final DateTime createdAt;
  final List<MessageReaction> reactions;
  final bool isDeleted;
  final bool isForwarded;
  final bool isStarred;
  final String? mediaEmoji;
  final String? fileName;
  final String? fileExt;
  final int? fileSize;
  final int? audioDuration;
  final String? locationName;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.type,
    this.text,
    this.replyTo,
    required this.status,
    required this.createdAt,
    this.reactions = const [],
    this.isDeleted = false,
    this.isForwarded = false,
    this.isStarred = false,
    this.mediaEmoji,
    this.fileName,
    this.fileExt,
    this.fileSize,
    this.audioDuration,
    this.locationName,
  });

  bool get isMe => senderId == 'me';

  String get timeText {
    final h = createdAt.hour.toString().padLeft(2, '0');
    final m = createdAt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  ChatMessage copyWith({
    List<MessageReaction>? reactions,
    bool? isDeleted, bool? isStarred, MessageStatus? status,
  }) => ChatMessage(
    id: id, senderId: senderId, type: type, text: text,
    replyTo: replyTo, status: status ?? this.status,
    createdAt: createdAt,
    reactions: reactions ?? this.reactions,
    isDeleted: isDeleted ?? this.isDeleted,
    isForwarded: isForwarded,
    isStarred: isStarred ?? this.isStarred,
    mediaEmoji: mediaEmoji, fileName: fileName,
    fileExt: fileExt, fileSize: fileSize,
    audioDuration: audioDuration, locationName: locationName,
  );
}

class Conversation {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isGroup;
  final bool isOnline;
  final bool isMuted;
  final bool isPinned;
  final bool isVerified;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final MessageStatus? lastMessageStatus;

  const Conversation({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.isGroup = false,
    this.isOnline = false,
    this.isMuted = false,
    this.isPinned = false,
    this.isVerified = false,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
    this.lastMessageStatus,
  });

  static List<Conversation> getMockConversations() => [
    Conversation(id: 'c1', name: 'Sarah Ahmed', isOnline: true, isVerified: true,
      isPinned: true, unreadCount: 3,
      lastMessage: 'Hey! Are you free tonight? 😊',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 2)),
      lastMessageStatus: MessageStatus.delivered),
    Conversation(id: 'c2', name: 'Dev Squad 🚀', isGroup: true,
      unreadCount: 12,
      lastMessage: 'Ahmed: pushed the fix to main ✅',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15))),
    Conversation(id: 'c3', name: 'Nora M.', isOnline: false,
      lastMessage: 'Thanks so much! ❤️',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      lastMessageStatus: MessageStatus.read),
    Conversation(id: 'c4', name: 'Karim', isOnline: true,
      lastMessage: 'Check this out 👀',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3))),
    Conversation(id: 'c5', name: 'Family 👨‍👩‍👧‍👦', isGroup: true, isMuted: true,
      lastMessage: 'Mama: تعالوا على العشاء',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 5))),
    Conversation(id: 'c6', name: 'Lina', isOnline: false,
      lastMessage: 'See you tomorrow!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      lastMessageStatus: MessageStatus.read),
  ];
}

class ChatMockData {
  static List<ChatMessage> getMockMessages() {
    final now = DateTime.now();
    return [
      ChatMessage(id: '1', senderId: 'other', type: MessageType.text,
        text: 'Hey! 👋 How are you?',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(hours: 2, minutes: 30))),
      ChatMessage(id: '2', senderId: 'me', type: MessageType.text,
        text: 'I\'m good! Just working on the app 💻',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(hours: 2, minutes: 28))),
      ChatMessage(id: '3', senderId: 'other', type: MessageType.text,
        text: 'That\'s awesome! How is it going?',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(hours: 2, minutes: 20))),
      ChatMessage(id: '4', senderId: 'me', type: MessageType.image,
        mediaEmoji: '🖼️', status: MessageStatus.read,
        createdAt: now.subtract(const Duration(hours: 2, minutes: 10))),
      ChatMessage(id: '5', senderId: 'other', type: MessageType.text,
        text: 'Looks amazing! 🔥🔥🔥',
        reactions: const [
          MessageReaction(emoji: '❤️', count: 1, isMyReaction: true),
          MessageReaction(emoji: '🔥', count: 2),
        ],
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(hours: 1, minutes: 50))),
      ChatMessage(id: '6', senderId: 'me', type: MessageType.audio,
        audioDuration: 12, status: MessageStatus.read,
        createdAt: now.subtract(const Duration(hours: 1, minutes: 30))),
      ChatMessage(id: '7', senderId: 'other', type: MessageType.text,
        text: 'Got your voice note! Will listen shortly',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 45))),
      ChatMessage(id: '8', senderId: 'me', type: MessageType.text,
        text: 'No rush 😊',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 44))),
      ChatMessage(id: '9', senderId: 'other', type: MessageType.text,
        text: 'Are you free tonight?',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 10))),
      ChatMessage(id: '10', senderId: 'me', type: MessageType.text,
        text: 'Yes! What\'s up? 🙌',
        status: MessageStatus.delivered,
        createdAt: now.subtract(const Duration(minutes: 2))),
    ];
  }
}
