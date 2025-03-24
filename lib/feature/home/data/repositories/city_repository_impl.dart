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
      return CityEntity(name: entry.key, coordinates: entry.value);
    }).toList();
  }
}
