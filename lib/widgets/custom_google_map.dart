import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});
  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 10,
      target: LatLng(37.7749, -122.4194), // _
    );

    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyles();
          },
          initialCameraPosition: initialCameraPosition,
        ),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              // CameraPosition newCameraPosition = const CameraPosition(
              //   target: LatLng(34.0522, -118.2437), // Los Angeles
              //   zoom: 12,
              // );

              googleMapController.animateCamera(
                CameraUpdate.newLatLng(LatLng(34.0522, -118.2437)), //
              );
            },
            child: Text('change camera position'),
          ),
        ),
      ],
    );
  }

  void initMapStyles() async {
    var nightStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styels/map_styels.json');
    googleMapController.setMapStyle(nightStyle);
  }
}
