import '../models/live_audio_room_model.dart';
import '../models/speaker_model.dart';

final List<LiveAudioRoomModel> mockAudioRooms = [
  LiveAudioRoomModel(
    id: 'ar1',
    hostId: 'h1',
    hostName: 'Ahmed',
    hostAvatar: '🧑',
    title: 'حديث تقني: مستقبل Flutter',
    speakers: [
      SpeakerModel(userId: 'h1', userName: 'Ahmed', avatar: '🧑', isMuted: false, isSpeaking: true),
      SpeakerModel(userId: 'sp2', userName: 'Sara', avatar: '👩', isMuted: true, isSpeaking: false),
    ],
    raisedHands: ['u3', 'u4'],
    listenerCount: 120,
    isLive: true,
    category: 'تقنية',
  ),
  LiveAudioRoomModel(
    id: 'ar2',
    hostId: 'h2',
    hostName: 'Lina',
    hostAvatar: '👩‍🎤',
    title: 'جلسة موسيقية حرة 🎵',
    speakers: [
      SpeakerModel(userId: 'h2', userName: 'Lina', avatar: '👩‍🎤', isMuted: false, isSpeaking: false),
    ],
    raisedHands: [],
    listenerCount: 85,
    isLive: true,
    category: 'موسيقى',
  ),
];
