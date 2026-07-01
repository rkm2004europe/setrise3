import '../models/album_model.dart';
import 'mock_tracks.dart';

final List<AlbumModel> mockAlbums = [
  AlbumModel(id: 'al1', title: 'After Hours', artist: 'The Weeknd', coverEmoji: '🌅', year: 2020, tracks: [mockTracks[1], mockTracks[4]]),
  AlbumModel(id: 'al2', title: '÷', artist: 'Ed Sheeran', coverEmoji: '➗', year: 2017, tracks: [mockTracks[3]]),
  AlbumModel(id: 'al3', title: 'Future Nostalgia', artist: 'Dua Lipa', coverEmoji: '💫', year: 2020, tracks: [mockTracks[7]]),
  AlbumModel(id: 'al4', title: 'Hotel California', artist: 'Eagles', coverEmoji: '🏜️', year: 1976, tracks: [mockTracks[6]]),
];
