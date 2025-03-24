import 'package:google_maps_flutter/google_maps_flutter.dart';

class CityEntity {
  final String name;
  final List<LatLng> coordinates;

  CityEntity({required this.name, required this.coordinates});
}
