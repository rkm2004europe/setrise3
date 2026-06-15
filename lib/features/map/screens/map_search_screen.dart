Enterimport 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_colors.dart';
import '../models/place_model.dart';
import '../services/map_search_service.dart';
import '../widgets/place_info_sheet.dart';

class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({super.key});

  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  final _searchCtrl = TextEditingController();
  final MapSearchService _service = MapSearchService();
  List<PlaceModel> _results = [];
  GoogleMapController? _mapCtrl;
  Set<Marker> _markers = {};

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _search(String query) async {
    final results = await _service.search(query);
    setState(() {
      _results = results;
      _markers = results
          .map((p) => Marker(
                markerId: MarkerId(p.id),
                position: LatLng(p.lat, p.lng),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(title: p.name, snippet: p.type),
                onTap: () => _showPlaceInfo(p),
              ))
          .toSet();
    });
  }

  void _showPlaceInfo(PlaceModel place) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => PlaceInfoSheet(place: place),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // شريط البحث
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: MapColors.text, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      autofocus: true,
                      style: const TextStyle(color: MapColors.text),
                      decoration: InputDecoration(
                        hintText: 'ابحث عن مكان، مطعم، متجر...',
                        hintStyle: TextStyle(color: MapColors.text2.withOpacity(0.5)),
                        border: InputBorder.none,
                      ),
                      onChanged: _search,
                    ),
                  ),
                ],
              ),
            ),
            // الخريطة
            Expanded(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(36.7538, 3.0588),
                  zoom: 14,
                ),
                markers: _markers,
                onMapCreated: (ctrl) => _mapCtrl = ctrl,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
              ),
            ),
            // قائمة النتائج
            if (_results.isNotEmpty)
              SizedBox(
                height: 150,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _results.length,
                  itemBuilder: (_, i) {
                    final place = _results[i];
                    return ListTile(
                      leading: Text(place.imageEmoji ?? '📍', style: const TextStyle(fontSize: 24)),
                      title: Text(place.name, style: const TextStyle(color: MapColors.text)),
                      subtitle: Text(place.type, style: const TextStyle(color: MapColors.text2)),
                      onTap: () => _showPlaceInfo(place),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
