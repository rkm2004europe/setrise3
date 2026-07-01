import '../models/playlist_model.dart';
import 'mock_tracks.dart';

final List<PlaylistModel> mockPlaylists = [
  PlaylistModel(id: 'pl1', name: 'أفضل الأغاني 2024', coverEmoji: '🔥', creator: 'SetRise', trackCount: 50, tracks: [mockTracks[0], mockTracks[1], mockTracks[3]]),
  PlaylistModel(id: 'pl2', name: 'روائع الروك', coverEmoji: '🎸', creator: 'Ahmed', trackCount: 30, tracks: [mockTracks[2], mockTracks[6]]),
  PlaylistModel(id: 'pl3', name: 'استرخاء', coverEmoji: '🧘', creator: 'SetRise', trackCount: 25, tracks: [mockTracks[0], mockTracks[8]]),
  PlaylistModel(id: 'pl4', name: 'تمارين', coverEmoji: '💪', creator: 'Sara', trackCount: 40, tracks: [mockTracks[1], mockTracks[4], mockTracks[9]]),
];
