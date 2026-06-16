import '../models/voice_room_model.dart';

final List<VoiceRoomParticipant> mockVoiceParticipants = [
  VoiceRoomParticipant(userId: 'h1', userName: 'Ahmed', avatar: '🧑', role: VoiceRoomRole.host, isMuted: false),
  VoiceRoomParticipant(userId: 'u1', userName: 'Sara', avatar: '👩', role: VoiceRoomRole.moderator, isMuted: false),
  VoiceRoomParticipant(userId: 'u2', userName: 'Omar', avatar: '👨', role: VoiceRoomRole.speaker, isMuted: true),
  VoiceRoomParticipant(userId: 'u3', userName: 'Lina', avatar: '👩‍🦰', role: VoiceRoomRole.listener, isMuted: true, hasRaisedHand: true),
  VoiceRoomParticipant(userId: 'u4', userName: 'Karim', avatar: '🧔', role: VoiceRoomRole.listener, isMuted: true),
];
