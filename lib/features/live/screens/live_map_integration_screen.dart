import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_colors.dart';

class LiveMapIntegrationScreen extends StatelessWidget {
  const LiveMapIntegrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(target: LatLng(36.7538, 3.0588), zoom: 14),
                markers: {
                  Marker(markerId: const MarkerId('live'), position: const LatLng(36.7538, 3.0588), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
                },
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
      const Text('خريطة البثوث', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
