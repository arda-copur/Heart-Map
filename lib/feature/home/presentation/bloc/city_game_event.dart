import 'package:heartmap/feature/home/presentation/bloc/city_game_state.dart';

abstract class CityGameEvent {}

class LoadCountriesEvent extends CityGameEvent {}

class SelectCountryEvent extends CityGameEvent {
  final String country;
  
  SelectCountryEvent({required this.country});
}

class SelectDifficultyEvent extends CityGameEvent {
  final DifficultyLevel difficulty;
  
  SelectDifficultyEvent({required this.difficulty});
}

class StartGameEvent extends CityGameEvent {
  final String country;
  final DifficultyLevel difficulty;
  
  StartGameEvent({required this.country, required this.difficulty});
}

class NextQuestionEvent extends CityGameEvent {}

class CheckAnswerEvent extends CityGameEvent {
  final String selectedCity;

  CheckAnswerEvent({required this.selectedCity});
}

class TimerTickEvent extends CityGameEvent {}

class RestartGameEvent extends CityGameEvent {}
