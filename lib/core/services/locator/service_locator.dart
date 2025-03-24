import 'package:get_it/get_it.dart';
import 'package:heartmap/core/services/audio/audio_manager.dart';
import 'package:heartmap/feature/home/data/datasources/city_data_source.dart';
import 'package:heartmap/feature/home/data/repositories/city_repository_impl.dart';
import 'package:heartmap/feature/home/domain/usecases/get_random_city.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AudioManager>(AudioManager());

  getIt.registerSingleton<CityDataSource>(CityDataSource());

  getIt.registerSingleton<CityRepositoryImpl>(
    CityRepositoryImpl(dataSource: getIt<CityDataSource>()),
  );

  getIt.registerSingleton<GetRandomCity>(
    GetRandomCity(repository: getIt<CityRepositoryImpl>()),
  );

  getIt.registerFactory<CityGameBloc>(
    () => CityGameBloc(
      audioManager: getIt<AudioManager>(),
      getRandomCity: getIt<GetRandomCity>(),
    ),
  );
}
