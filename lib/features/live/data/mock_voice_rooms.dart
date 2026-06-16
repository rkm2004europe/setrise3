import '../models/voice_room_model.dart';

final List<VoiceRoomModel> mockVoiceRooms = [
  VoiceRoomModel(
    id: 'vr1', hostId: 'h1', hostName: 'Ahmed', hostAvatar: '🧑',
    title: 'حديث الموسيقى 🎵', topicEmoji: '🎙️', tags: ['موسيقى', 'فن'],
    listenerCount: 45, speakerCount: 3, isLive: true,
  ),
  VoiceRoomModel(
    id: 'vr2', hostId: 'h2', hostName: 'Sara', hostAvatar: '👩',
    title: 'نادي الكتاب 📚', topicEmoji: '📖', tags: ['قراءة', 'ثقافة'],
    listenerCount: 28, speakerCount: 2, isLive: true,
  ),
];
