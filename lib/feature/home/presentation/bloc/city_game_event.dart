abstract class CityGameEvent {}

class StartGameEvent extends CityGameEvent {}

class NextQuestionEvent extends CityGameEvent {}

class CheckAnswerEvent extends CityGameEvent {
  final String selectedCity;

  CheckAnswerEvent({required this.selectedCity});
}
