import 'package:google_maps_flutter/google_maps_flutter.dart';

class CityEntity {
  final String name;
  final List<LatLng> coordinates;
  final String country;
  final String region;

  CityEntity({
    required this.name, 
    required this.coordinates,
    required this.country,
    required this.region
  });
}
