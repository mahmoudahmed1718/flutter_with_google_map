import 'package:flutter/material.dart';
import 'package:flutter_map/models/place_model.dart';
import 'package:flutter_map/utils/assets.dart';
import 'package:flutter_map/utils/show_snak_bar_method.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});
  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  late Location location;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 10,
      target: LatLng(37.7749, -122.4194), // _
    );
    // initCircle();
    // initPloyline();
    checkUserLocation();
    getLocationService();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Set<Circle> circles = {};
  Set<Polyline> polies = {};
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

  void initMarker() async {
    var customMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      Assets.assetsImagesIconMarker,
    );
    var myMaker = places
        .map(
          (place) => Marker(
            icon: customMarkerIcon,
            markerId: MarkerId(place.id.toString()),
            position: place.latLng,
            infoWindow: InfoWindow(title: place.name),
          ),
        )
        .toSet();
    markers.addAll(myMaker);
    setState(() {
      markers = markers;
    });
  }

  void initPloyline() {
    Polyline polyline = Polyline(
      polylineId: const PolylineId('1'),
      points: places.map((place) => place.latLng).toList(),
    );
    polies.add(polyline);
    setState(() {
      polies = polies;
    });
  }

  void initCircle() {
    Circle veroClothingStoreService = Circle(
      fillColor: Colors.black.withValues(alpha: 0.7),
      circleId: CircleId('1'),
      center: const LatLng(31.23335288295843, 29.955435384540227),

      radius: 10000,
    );
    circles.add(veroClothingStoreService);
  }

  void checkUserLocation() async {
    var isEnabledLocation = await location.serviceEnabled();
    if (!isEnabledLocation) {
      isEnabledLocation = await location.requestService();
    }
  }

  void checkUserPermission() async {
    var isEnabledLocation = await location.hasPermission();
    if (isEnabledLocation == PermissionStatus.denied) {
      isEnabledLocation = await location.requestPermission();
    }
    if (isEnabledLocation == PermissionStatus.granted) {
      showSnakBar(
        // ignore: use_build_context_synchronously
        context: context,
        message: 'you need to allow to access your location',
      );
    }
  }

  void getLocationService() {
    location.onLocationChanged.listen((event) {});
  }
}
