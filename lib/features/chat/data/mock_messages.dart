import '../models/models.dart';

List<Message> mockMessages() {
  final now = DateTime.now();
  return [
    Message(id: '1', senderId: 'u1', type: MsgType.text, text: 'مرحباً!', status: MsgStatus.read, createdAt: now.subtract(const Duration(hours: 2))),
    Message(id: '2', senderId: 'me', type: MsgType.text, text: 'أهلاً وسهلاً', status: MsgStatus.read, createdAt: now.subtract(const Duration(hours: 1))),
    Message(id: '3', senderId: 'u1', type: MsgType.image, mediaEmoji: '🖼️', status: MsgStatus.read, createdAt: now.subtract(const Duration(minutes: 45))),
    Message(id: '4', senderId: 'me', type: MsgType.video, mediaEmoji: '🎥', status: MsgStatus.delivered, createdAt: now.subtract(const Duration(minutes: 30))),
    Message(id: '5', senderId: 'u1', type: MsgType.audio, audioDuration: 12, status: MsgStatus.read, createdAt: now.subtract(const Duration(minutes: 10))),
    Message(id: '6', senderId: 'me', type: MsgType.file, fileName: 'تقرير.pdf', fileExt: 'pdf', fileSize: 2048000, status: MsgStatus.sent, createdAt: now.subtract(const Duration(minutes: 5))),
    Message(id: '7', senderId: 'u1', type: MsgType.location, locationName: 'الجزائر العاصمة', status: MsgStatus.read, createdAt: now.subtract(const Duration(minutes: 2))),
  ];
}
