import 'package:heartmap/feature/home/domain/entities/city_entity.dart';

class CityGameUtils {
  static List<String> generateOptions(String correctCity, List<CityEntity> cities) {
    final allCityNames = cities.map((city) => city.name).toList();
    allCityNames.remove(correctCity);
    final randomCities = (allCityNames.toList()..shuffle()).take(2).toList();
    final options = [...randomCities, correctCity]..shuffle();
    return options;
  }
  
  static List<String> generateRegionBasedOptions(CityEntity correctCity, List<CityEntity> allCities, {int optionCount = 3}) {
    // Aynı bölgedeki şehirleri bul
    final regionCities = allCities
        .where((city) => 
            city.country == correctCity.country && 
            city.region == correctCity.region &&
            city.name != correctCity.name)
        .map((city) => city.name)
        .toList();
    
    // Eğer aynı bölgede yeterli şehir yoksa, rastgele şehirlerle tamamla
    List<String> options = [correctCity.name];
    
    if (regionCities.length >= optionCount) {
      // Bölgeden rastgele şehirler seç
      regionCities.shuffle();
      options.addAll(regionCities.take(optionCount));
    } else {
      // Mevcut bölge şehirlerini ekle
      options.addAll(regionCities);
      
      // Geriye kalan seçenekleri rastgele şehirlerden seç
      final otherCities = allCities
          .where((city) => 
              !(city.country == correctCity.country && 
                city.region == correctCity.region) &&
              city.name != correctCity.name)
          .map((city) => city.name)
          .toList()
        ..shuffle();
      
      final remainingCount = optionCount + 1 - options.length;
      options.addAll(otherCities.take(remainingCount));
    }
    
    // Seçenekleri karıştır
    options.shuffle();
    
    return options.take(optionCount + 1).toList();
  }
}