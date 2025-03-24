import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CityGameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends CityGameState {}

class GameStartedState extends CityGameState {
  final String questionText;
  final List<String> options;
  final Set<Marker> markers;

  GameStartedState({
    required this.questionText,
    required this.options,
    required this.markers,
  });

  @override
  List<Object?> get props => [questionText, options, markers];
}

class AnswerCheckedState extends CityGameState {
  final bool isCorrect;
  final String feedbackText;

  AnswerCheckedState({
    required this.isCorrect,
    required this.feedbackText,
  });

  @override
  List<Object?> get props => [isCorrect, feedbackText];
}

class GameEndedState extends CityGameState {}
