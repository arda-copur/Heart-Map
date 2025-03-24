import 'package:heartmap/feature/home/domain/entities/city_entity.dart';

class CityGameUtils {
  static List<String> generateOptions(String correctCity, List<CityEntity> cities) {
    final allCityNames = cities.map((city) => city.name).toList();
    allCityNames.remove(correctCity);
    final randomCities = (allCityNames.toList()..shuffle()).take(2).toList();
    final options = [...randomCities, correctCity]..shuffle();
    return options;
  }
}