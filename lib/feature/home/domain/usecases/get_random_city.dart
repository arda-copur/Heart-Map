import 'dart:math';

import 'package:heartmap/feature/home/domain/entities/city_entity.dart';
import 'package:heartmap/feature/home/domain/repositories/city_repository.dart';

class GetRandomCity {
  final CityRepository repository;

  GetRandomCity({required this.repository});

  CityEntity call() {
    final cities = repository.getCities();
    final randomIndex = Random().nextInt(cities.length);
    return cities[randomIndex];
  }

  
}
