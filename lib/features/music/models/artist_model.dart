class ArtistModel {
  final String id;
  final String name;
  final String avatarEmoji;
  final int monthlyListeners;
  final List<String> topTracks;
  bool isFollowed;

  ArtistModel({
    required this.id,
    required this.name,
    required this.avatarEmoji,
    this.monthlyListeners = 0,
    this.topTracks = const [],
    this.isFollowed = false,
  });
}
