import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});
  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 10,
      target: LatLng(37.7749, -122.4194), // _
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      cameraTargetBounds: CameraTargetBounds(
        LatLngBounds(
          southwest: LatLng(37.7749, -122.4194), // Southwest corner
          northeast: LatLng(37.8049, -122.3894), // Northeast corner
        ),
      ),
      initialCameraPosition: initialCameraPosition,
    );
  }
}
