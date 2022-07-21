import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_example/place_card/place_card.dart';
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
  Place? _selectedPlace;
  final List<String> _likedPlaceIds = [];

  Future<void> _unselectPlace() async {
    if (_selectedPlace == null) return;

    final place = _selectedPlace;
    setState(() {
      _selectedPlace = null;
    });

    await _upsertMarker(place!);
  }

  Future<void> _selectPlace(Place place) async {
    await _unselectPlace();

    setState(() {
      _selectedPlace = place;
    });

    await _upsertMarker(place);
  }

  Future<void> _upsertMarker(Place place) async {
    final selectedPrefix = place.id == _selectedPlace?.id ? "selected_" : "";
    final favoritePostfix =
        _likedPlaceIds.contains(place.id) ? "_favorite" : "";

    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/${selectedPrefix}map_place$favoritePostfix.png",
    );

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(place.id),
        position: place.location,
        onTap: () => _selectPlace(place),
        icon: icon,
      ));
    });
  }

  void _mapPlacesToMarkers() {
    for (final place in _places) {
      _upsertMarker(place);
    }
  }

  void _likeTapHandler() async {
    if (_selectedPlace == null) return;
    setState(() {
      if (_likedPlaceIds.contains(_selectedPlace!.id)) {
        _likedPlaceIds.removeAt(_likedPlaceIds.indexOf(_selectedPlace!.id));
      } else {
        _likedPlaceIds.add(_selectedPlace!.id);
      }
    });

    _upsertMarker(_selectedPlace!);
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
    _likedPlaceIds.addAll([_places[0].id, _places[3].id]);
    _mapPlacesToMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: _center,
            zoom: 12,
          ),
          markers: _markers,
          onTap: (_) => _unselectPlace(),
        ),
        if (_selectedPlace != null)
          Positioned(
            bottom: 76,
            child: PhysicalModel(
              color: Colors.black,
              shadowColor: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
              elevation: 12,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MapPlaceCard(
                  place: _selectedPlace!,
                  isLiked: _likedPlaceIds.contains(_selectedPlace!.id),
                  likeTapHandler: _likeTapHandler,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
