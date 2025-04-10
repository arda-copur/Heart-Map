import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum DifficultyLevel { easy, medium, hard }

abstract class CityGameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends CityGameState {}

class CountrySelectionState extends CityGameState {
  final List<String> countries;
  
  CountrySelectionState({required this.countries});
  
  @override
  List<Object?> get props => [countries];
}

class DifficultySelectionState extends CityGameState {
  final String selectedCountry;
  
  DifficultySelectionState({required this.selectedCountry});
  
  @override
  List<Object?> get props => [selectedCountry];
}

class GameStartedState extends CityGameState {
  final String questionText;
  final List<String> options;
  final Set<Marker> markers;
  final int score;
  final int totalQuestions;
  final int currentQuestion;
  final int timeRemaining;
  final String selectedCountry;
  final DifficultyLevel difficulty;

  GameStartedState({
    required this.questionText,
    required this.options,
    required this.markers,
    this.score = 0,
    this.totalQuestions = 10,
    this.currentQuestion = 1,
    this.timeRemaining = 15,
    required this.selectedCountry,
    required this.difficulty,
  });

  @override
  List<Object?> get props => [
    questionText, 
    options, 
    markers, 
    score, 
    totalQuestions, 
    currentQuestion, 
    timeRemaining,
    selectedCountry,
    difficulty,
  ];

  GameStartedState copyWith({
    String? questionText,
    List<String>? options,
    Set<Marker>? markers,
    int? score,
    int? totalQuestions,
    int? currentQuestion,
    int? timeRemaining,
    String? selectedCountry,
    DifficultyLevel? difficulty,
  }) {
    return GameStartedState(
      questionText: questionText ?? this.questionText,
      options: options ?? this.options,
      markers: markers ?? this.markers,
      score: score ?? this.score,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}

class AnswerCheckedState extends CityGameState {
  final bool isCorrect;
  final String feedbackText;
  final int score;
  final int totalQuestions;
  final int currentQuestion;
  final int scoreIncrease;
  final String selectedCountry;
  final DifficultyLevel difficulty;

  AnswerCheckedState({
    required this.isCorrect,
    required this.feedbackText,
    required this.score,
    required this.totalQuestions,
    required this.currentQuestion,
    required this.scoreIncrease,
    required this.selectedCountry,
    required this.difficulty,
  });

  @override
  List<Object?> get props => [
    isCorrect, 
    feedbackText, 
    score, 
    totalQuestions, 
    currentQuestion, 
    scoreIncrease,
    selectedCountry,
    difficulty,
  ];
}

class GameEndedState extends CityGameState {
  final int finalScore;
  final int totalQuestions;
  final String selectedCountry;
  final DifficultyLevel difficulty;

  GameEndedState({
    required this.finalScore,
    required this.totalQuestions,
    required this.selectedCountry,
    required this.difficulty,
  });

  @override
  List<Object?> get props => [finalScore, totalQuestions, selectedCountry, difficulty];
}
