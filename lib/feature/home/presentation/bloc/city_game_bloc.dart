import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heartmap/core/services/audio/audio_manager.dart';
import 'package:heartmap/core/utils/enum/app_sounds.dart';
import 'package:heartmap/feature/home/domain/usecases/get_random_city.dart';
import 'package:heartmap/feature/home/domain/utils/city_game_utils.dart';
import 'city_game_event.dart';
import 'city_game_state.dart';

class CityGameBloc extends Bloc<CityGameEvent, CityGameState> {
  final GetRandomCity getRandomCity;
  final Set<Marker> _markers = {};
  final AudioManager _audioManager;
  int gameIndex = 0;
  String? correctCity;

  CityGameBloc(
      {required this.getRandomCity, required AudioManager audioManager})
      : _audioManager = audioManager,
        super(InitialState()) {
    on<StartGameEvent>(_onStartGameEvent);
    on<NextQuestionEvent>(_onNextQuestionEvent);
    on<CheckAnswerEvent>(_onCheckAnswerEvent);
  }
  void _onStartGameEvent(
      StartGameEvent event, Emitter<CityGameState> emit) async {
    gameIndex = 0;
    emit(InitialState());
    add(NextQuestionEvent());
  }

  void _onNextQuestionEvent(
      NextQuestionEvent event, Emitter<CityGameState> emit) async {
    if (gameIndex >= 10) {
      emit(GameEndedState());
      return;
    }

    final city = getRandomCity();
    _markers.clear();
    _markers.add(Marker(
      markerId: const MarkerId("current"),
      position: city.coordinates[Random().nextInt(city.coordinates.length)],
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
    correctCity = city.name;
    gameIndex++;

    final cities = getRandomCity.repository.getCities();
    emit(GameStartedState(
      questionText: "Bu nokta hangi şehirde?",
      options: CityGameUtils.generateOptions(city.name, cities),
      markers: _markers,
    ));
  }

  void _onCheckAnswerEvent(
      CheckAnswerEvent event, Emitter<CityGameState> emit) async {
    final isCorrect = event.selectedCity == correctCity;

    if (isCorrect) {
      _audioManager.play(AppSounds.correctAnswer.path);
    } else {
      _audioManager.play(AppSounds.wrongAnswer.path);
    }

    emit(AnswerCheckedState(
      isCorrect: isCorrect,
      feedbackText: isCorrect
          ? "🎉 Doğru! Harikasın! 🎉"
          : "❌ Yanlış! Doğru cevap: $correctCity",
    ));

    await Future.delayed(const Duration(seconds: 2));
    add(NextQuestionEvent());
  }
}
