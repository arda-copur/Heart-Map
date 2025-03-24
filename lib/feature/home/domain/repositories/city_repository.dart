import 'package:heartmap/feature/home/domain/entities/city_entity.dart';

abstract class CityRepository {
  List<CityEntity> getCities();
}
