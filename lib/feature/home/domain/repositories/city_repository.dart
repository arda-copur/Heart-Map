import 'package:heartmap/feature/home/domain/entities/city_entity.dart';

abstract class CityRepository {
  List<CityEntity> getCities();
  List<String> getCountries();
  List<String> getRegions(String country);
  List<CityEntity> getCitiesInRegion(String country, String region);
  List<CityEntity> getCitiesInCountry(String country);
}
