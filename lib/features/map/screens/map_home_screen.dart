hereimport 'package:flutter/material.dart';
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
import '../widgets/place_info_sheet.dart';
import '../widgets/map_marker.dart';
import '../widgets/story_cluster.dart';
import '../controllers/map_controller.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  late GoogleMapController _mapCtrl;
  final MapController _controller = MapController();
  Set<Marker> _markers = {};
  final List<MapStoryModel> _stories = mockMapStories.where((s) => !s.isExpired).toList();
  final List<HotspotModel> _hotspots = mockHotspots;
  final List<PlaceModel> _places = mockPlaces;
  final List<ChallengeModel> _challenges = mockChallenges.where((c) => c.isActive).toList();
  final List<EventModel> _events = mockEvents;

  @override
  void initState() {
    super.initState();
    _buildMarkers();
  }

  void _buildMarkers() {
    final markers = <Marker>{};

    // Stories
    for (final story in _stories) {
      markers.add(MapMarker.buildStoryMarker(story, () {
        _showStoryCluster(story);
      }));
    }

    // Hotspots
    for (final hotspot in _hotspots) {
      markers.add(MapMarker.buildHotspotMarker(hotspot, () {
        _showHotspotInfo(hotspot);
      }));
    }

    // Places
    for (final place in _places) {
      markers.add(MapMarker.buildPlaceMarker(place, () {
        _showPlaceInfo(place);
      }));
    }

    // Challenges
    for (final challenge in _challenges) {
      markers.add(MapMarker.buildChallengeMarker(challenge, () {
        _showChallengeInfo(challenge);
      }));
    }

    // Events
    for (final event in _events) {
      markers.add(MapMarker.buildEventMarker(event, () {
        _showEventInfo(event);
      }));
    }

    setState(() => _markers = markers);
  }

  void _showStoryCluster(MapStoryModel story) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => StoryCluster(stories: _stories, initialStory: story),
    );
  }

  void _showPlaceInfo(PlaceModel place) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => PlaceInfoSheet(place: place),
    );
  }

  void _showHotspotInfo(HotspotModel hotspot) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${hotspot.name}: ${hotspot.activityCount} نشاط'), backgroundColor: MapColors.accent),
    );
  }

  void _showChallengeInfo(ChallengeModel challenge) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${challenge.title}: جائزة ${challenge.reward} نقطة'), backgroundColor: MapColors.gold),
    );
  }

  void _showEventInfo(EventModel event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${event.title}: ${event.attendeesCount} حاضر'), backgroundColor: MapColors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapColors.bg,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(36.7538, 3.0588),
              zoom: 14,
            ),
            markers: _markers,
            onMapCreated: (ctrl) => _mapCtrl = ctrl,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),
          // شريط علوي شفاف
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: MapColors.bg.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
                    child: const Text('الخريطة', style: TextStyle(color: MapColors.text, fontWeight: FontWeight.w800)),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: MapColors.bg.withOpacity(0.8), shape: BoxShape.circle),
                      child: const Icon(Icons.tune, color: MapColors.text),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // أزرار جانبية
          Positioned(
            right: 16,
            bottom: 120,
            child: Column(
              children: [
                _buildActionButton(Icons.my_location, () {}),
                const SizedBox(height: 8),
                _buildActionButton(Icons.add, () {}),
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
      decoration: BoxDecoration(color: MapColors.bg.withOpacity(0.8), shape: BoxShape.circle),
      child: Icon(icon, color: MapColors.text, size: 22),
    ),
  );
}
