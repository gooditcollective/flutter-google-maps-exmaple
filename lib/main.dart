import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'datasource.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: CustomMap(),
      ),
    );
  }
}

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  GoogleMapController? _controller;
  static const LatLng _center = LatLng(48.864716, 2.349014);
  final Set<Marker> _markers = {};

  final List<Place> _places = places;

  void _upsertMarker(Place place) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(place.id),
        position: place.location,
        infoWindow: InfoWindow(
          title: place.name,
          snippet:
              [...place.occasions, ...place.vibes, ...place.budget].join(", "),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _mapPlacesToMarkers() {
    for (final place in _places) {
      _upsertMarker(place);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });

    rootBundle.loadString('assets/map_style.json').then((mapStyle) {
      _controller?.setMapStyle(mapStyle);
    });
  }

  @override
  initState() {
    super.initState();
    _mapPlacesToMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: _center,
        zoom: 12,
      ),
      markers: _markers,
    );
  }
}
