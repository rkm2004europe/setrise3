class MediaLocation {
  final String id;
  final String mediaUrl;
  final String description;
  final double lat;
  final double lng;

  MediaLocation({
    required this.id,
    required this.mediaUrl,
    required this.description,
    required this.lat,
    required this.lng,
  });
}

final List<MediaLocation> mockMediaLocations = [
  MediaLocation(id: 'm1', mediaUrl: 'video1', description: 'فيديو من وسط المدينة', lat: 36.754, lng: 3.056),
  MediaLocation(id: 'm2', mediaUrl: 'img1', description: 'صورة من الكورنيش', lat: 36.760, lng: 3.045),
];
