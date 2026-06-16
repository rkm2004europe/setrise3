import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_colors.dart';
import '../data/mock_live_rooms.dart';
import 'live_room_screen.dart';

class MapDiscoveryScreen extends StatelessWidget {
  const MapDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = mockLiveRooms.where((r) => r.isLive && r.lat != null && r.lng != null).toList();
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(target: LatLng(36.7538, 3.0588), zoom: 14),
                markers: rooms.map((r) => Marker(
                  markerId: MarkerId(r.id),
                  position: LatLng(r.lat!, r.lng!),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  infoWindow: InfoWindow(title: r.title, snippet: r.hostName),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LiveRoomScreen(room: r))),
                )).toSet(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
      const SizedBox(width: 12),
      const Text('بثوث قريبة', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
