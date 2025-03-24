import 'package:google_maps_flutter/google_maps_flutter.dart';

class CityModel {
  final String name;
  final List<LatLng> coordinates;

  CityModel({required this.name, required this.coordinates});
}