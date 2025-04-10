import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heartmap/feature/home/data/datasources/city_data_source.dart';
import 'package:heartmap/feature/home/domain/entities/city_entity.dart';
import 'package:heartmap/feature/home/domain/repositories/city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  final CityDataSource dataSource;

  CityRepositoryImpl({required this.dataSource});

  @override
  List<CityEntity> getCities() {
    final cityCoordinates = dataSource.getCityCoordinates();
    return cityCoordinates.entries.map((entry) {
      return CityEntity(
        name: entry.key, 
        coordinates: entry.value,
        country: _findCountry(entry.key),
        region: _findRegion(entry.key)
      );
    }).toList();
  }

  @override
  List<String> getCountries() {
    return dataSource.getCountries();
  }

  @override
  List<String> getRegions(String country) {
    return dataSource.getRegions(country);
  }

  @override
  List<CityEntity> getCitiesInRegion(String country, String region) {
    final cities = dataSource.getCitiesInRegion(country, region);
    return cities.map((cityName) {
      final coordinates = _getCityCoordinates(country, region, cityName);
      return CityEntity(
        name: cityName, 
        coordinates: coordinates, 
        country: country, 
        region: region
      );
    }).toList();
  }

  @override
  List<CityEntity> getCitiesInCountry(String country) {
    List<CityEntity> cities = [];
    final regions = getRegions(country);
    
    for (var region in regions) {
      cities.addAll(getCitiesInRegion(country, region));
    }
    
    return cities;
  }

  // Yardımcı metodlar
  String _findCountry(String cityName) {
    final allData = dataSource.getAllCitiesData();
    for (var countryEntry in allData.entries) {
      for (var regionEntry in countryEntry.value.entries) {
        if (regionEntry.value.containsKey(cityName)) {
          return countryEntry.key;
        }
      }
    }
    return "Bilinmiyor";
  }

  String _findRegion(String cityName) {
    final allData = dataSource.getAllCitiesData();
    for (var countryEntry in allData.entries) {
      for (var regionEntry in countryEntry.value.entries) {
        if (regionEntry.value.containsKey(cityName)) {
          return regionEntry.key;
        }
      }
    }
    return "Bilinmiyor";
  }

  List<LatLng> _getCityCoordinates(String country, String region, String cityName) {
    final coords = dataSource.getAllCitiesData()[country]?[region]?[cityName];
    if (coords == null) {
      return [];
    }
    // List<dynamic>'i List<LatLng>'e çeviriyoruz
    return List<LatLng>.from(coords);
  }
}
