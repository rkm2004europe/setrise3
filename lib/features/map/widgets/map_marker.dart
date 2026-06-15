import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/map_story_model.dart';
import '../models/hotspot_model.dart';
import '../models/place_model.dart';
import '../models/challenge_model.dart';
import '../models/event_model.dart';

class MapMarker {
  static Marker buildStoryMarker(MapStoryModel story, VoidCallback onTap) {
    return Marker(
      markerId: MarkerId(story.id),
      position: LatLng(story.lat, story.lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(story.isLive ? BitmapDescriptor.hueRed : BitmapDescriptor.hueViolet),
      onTap: onTap,
      infoWindow: InfoWindow(title: story.userName, snippet: story.locationName),
    );
  }

  static Marker buildHotspotMarker(HotspotModel hotspot, VoidCallback onTap) {
    return Marker(
      markerId: MarkerId(hotspot.id),
      position: LatLng(hotspot.lat, hotspot.lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      onTap: onTap,
    );
  }

  static Marker buildPlaceMarker(PlaceModel place, VoidCallback onTap) {
    return Marker(
      markerId: MarkerId(place.id),
      position: LatLng(place.lat, place.lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      onTap: onTap,
      infoWindow: InfoWindow(title: place.name, snippet: place.type),
    );
  }

  static Marker buildChallengeMarker(ChallengeModel challenge, VoidCallback onTap) {
    return Marker(
      markerId: MarkerId(challenge.id),
      position: LatLng(challenge.lat, challenge.lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      onTap: onTap,
    );
  }

  static Marker buildEventMarker(EventModel event, VoidCallback onTap) {
    return Marker(
      markerId: MarkerId(event.id),
      position: LatLng(event.lat, event.lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      onTap: onTap,
    );
  }
}
