import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_colors.dart';
import '../models/map_story_model.dart';
import '../models/hotspot_model.dart';
import '../models/place_model.dart';
import '../models/challenge_model.dart';
import '../models/event_model.dart';
import '../data/mock_map_stories.dart';
import '../data/mock_hotspots.dart';
import '../data/mock_places.dart';
import '../data/mock_challenges.dart';
import '../data/mock_events.dart';
import '../data/mock_media_locations.dart';
import '../widgets/map_marker.dart';
import '../widgets/place_info_sheet.dart';
import '../widgets/story_cluster.dart';
import '../widgets/quick_filter_chips.dart';
import '../widgets/live_pulse_marker.dart';
import '../controllers/map_controller.dart';
import '../controllers/story_map_controller.dart';
import '../controllers/challenge_controller.dart';
import '../controllers/hotspot_controller.dart';
import '../controllers/event_controller.dart';
import 'story_viewer_screen.dart';
import 'challenge_detail_screen.dart';
import 'event_detail_screen.dart';
import 'place_profile_screen.dart';
import 'media_player_screen.dart';
import 'live_viewer_screen.dart';
import 'map_search_screen.dart';
import 'map_filter_screen.dart';
import 'create_event_screen.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  // Controllers
  final MapController _mapController = MapController();
  final StoryMapController _storyController = StoryMapController();
  final ChallengeController _challengeController = ChallengeController();
  final HotspotController _hotspotController = HotspotController();
  final EventController _eventController = EventController();

  // Map
  GoogleMapController? _googleMapCtrl;
  Set<Marker> _markers = {};

  // Data
  List<MapStoryModel> _stories = [];
  List<HotspotModel> _hotspots = [];
  List<PlaceModel> _places = [];
  List<ChallengeModel> _challenges = [];
  List<EventModel> _events = [];
  List<MediaLocation> _mediaLocations = [];

  // Filters
  Map<String, bool> _filters = {
    'stories': true,
    'live': true,
    'videos': true,
    'restaurants': true,
    'shops': true,
    'challenges': true,
    'events': true,
    'hotspots': true,
  };

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() => _isLoading = true);

    // تحميل الستوريز النشطة فقط (أقل من 24 ساعة)
    _stories = mockMapStories.where((s) => !s.isExpired).toList();
    _hotspots = mockHotspots;
    _places = mockPlaces;
    _challenges = mockChallenges.where((c) => c.isActive).toList();
    _events = mockEvents;
    _mediaLocations = mockMediaLocations;

    _buildAllMarkers();

    setState(() => _isLoading = false);
  }

  void _buildAllMarkers() {
    final markers = <Marker>{};

    // Stories
    if (_filters['stories'] == true) {
      for (final story in _stories) {
        markers.add(MapMarker.buildStoryMarker(story, () {
          _showStoryViewer(story);
        }));
      }
    }

    // Live streams
    if (_filters['live'] == true) {
      for (final story in _stories.where((s) => s.isLive)) {
        markers.add(Marker(
          markerId: MarkerId('live_${story.id}'),
          position: LatLng(story.lat, story.lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: 'بث مباشر: ${story.userName}'),
          onTap: () => _showLiveViewer(story.locationName, story.userName),
        ));
      }
    }

    // Media (Videos/Photos)
    if (_filters['videos'] == true) {
      for (final media in _mediaLocations) {
        markers.add(Marker(
          markerId: MarkerId('media_${media.id}'),
          position: LatLng(media.lat, media.lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(title: media.description),
          onTap: () => _showMediaPlayer(media.mediaUrl, media.description),
        ));
      }
    }

    // Hotspots
    if (_filters['hotspots'] == true) {
      for (final hotspot in _hotspots) {
        markers.add(MapMarker.buildHotspotMarker(hotspot, () {
          _showHotspotInfo(hotspot);
        }));
      }
    }

    // Places (Restaurants & Shops)
    if (_filters['restaurants'] == true || _filters['shops'] == true) {
      for (final place in _places) {
        bool show = false;
        if (place.type == 'مطعم' && _filters['restaurants'] == true) show = true;
        if (place.type == 'متجر' && _filters['shops'] == true) show = true;
        if (show) {
          markers.add(MapMarker.buildPlaceMarker(place, () {
            _showPlaceInfo(place);
          }));
        }
      }
    }

    // Challenges
    if (_filters['challenges'] == true) {
      for (final challenge in _challenges) {
        markers.add(MapMarker.buildChallengeMarker(challenge, () {
          _showChallengeDetail(challenge);
        }));
      }
    }

    // Events
    if (_filters['events'] == true) {
      for (final event in _events) {
        markers.add(MapMarker.buildEventMarker(event, () {
          _showEventDetail(event);
        }));
      }
    }

    setState(() => _markers = markers);
  }

  void _toggleFilter(String key, bool value) {
    setState(() {
      _filters[key] = value;
    });
    _buildAllMarkers();
  }

  void _applyFilters(Map<String, bool> newFilters) {
    setState(() {
      _filters = newFilters;
    });
    _buildAllMarkers();
  }

  // ─── Navigation to detail screens ──────────────────────────────────────

  void _showStoryViewer(MapStoryModel story) {
    final index = _stories.indexWhere((s) => s.id == story.id);
    if (index == -1) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StoryViewerScreen(
          stories: _stories,
          initialIndex: index,
        ),
      ),
    );
  }

  void _showPlaceInfo(PlaceModel place) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlaceProfileScreen(place: place)),
    );
  }

  void _showChallengeDetail(ChallengeModel challenge) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChallengeDetailScreen(challenge: challenge),
      ),
    );
  }

  void _showEventDetail(EventModel event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventDetailScreen(event: event),
      ),
    );
  }

  void _showMediaPlayer(String mediaUrl, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MediaPlayerScreen(
          mediaUrl: mediaUrl,
          description: description,
        ),
      ),
    );
  }

  void _showLiveViewer(String title, String host) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LiveViewerScreen(
          streamTitle: title,
          hostName: host,
        ),
      ),
    );
  }

  void _showHotspotInfo(HotspotModel hotspot) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${hotspot.name}: ${hotspot.activityCount} نشاط'),
        backgroundColor: MapColors.accent,
      ),
    );
  }

  void _goToCurrentLocation() async {
    // محاكاة الانتقال لموقع المستخدم الحالي
    _googleMapCtrl?.animateCamera(
      CameraUpdate.newLatLng(const LatLng(36.7538, 3.0588)),
    );
  }

  void _createEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CreateEventScreen(lat: 36.7538, lng: 3.0588),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapColors.bg,
      body: Stack(
        children: [
          // ══════════════════════ الخريطة ══════════════════════
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(36.7538, 3.0588),
              zoom: 14,
            ),
            markers: _markers,
            onMapCreated: (ctrl) => _googleMapCtrl = ctrl,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: MapColors.accent)),

          // ══════════════════════ شريط علوي ══════════════════════
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // عنوان
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: MapColors.bg.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'الخريطة',
                      style: TextStyle(
                        color: MapColors.text,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // بحث
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MapSearchScreen()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: MapColors.bg.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.search, color: MapColors.text, size: 22),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // فلترة
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push<Map<String, bool>>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MapFilterScreen(initialFilters: _filters),
                        ),
                      );
                      if (result != null) _applyFilters(result);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: MapColors.bg.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.tune, color: MapColors.text, size: 22),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ══════════════════════ فلاتر سريعة ══════════════════════
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: QuickFilterChips(
              filters: _filters,
              onToggle: _toggleFilter,
            ),
          ),

          // ══════════════════════ أزرار جانبية ══════════════════════
          Positioned(
            right: 16,
            bottom: 120,
            child: Column(
              children: [
                _buildActionButton(Icons.my_location, _goToCurrentLocation),
                const SizedBox(height: 8),
                _buildActionButton(Icons.add_location, _createEvent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MapColors.bg.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: MapColors.text, size: 22),
        ),
      );
}
