import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heartmap/core/services/audio/audio_manager.dart';
import 'package:heartmap/core/utils/enum/app_sounds.dart';
import 'package:heartmap/feature/home/domain/entities/city_entity.dart';
import 'package:heartmap/feature/home/domain/usecases/get_random_city.dart';
import 'package:heartmap/feature/home/domain/utils/city_game_utils.dart';
import 'city_game_event.dart';
import 'city_game_state.dart';
import 'package:flutter/foundation.dart';

class CityGameBloc extends Bloc<CityGameEvent, CityGameState> {
  final GetRandomCity getRandomCity;
  final AudioManager _audioManager;
  final Set<Marker> _markers = {};
  String? correctCity;
  int score = 0;
  int currentQuestion = 0;
  int totalQuestions = 10;
  String selectedCountry = "Türkiye";
  DifficultyLevel selectedDifficulty = DifficultyLevel.easy;
  Timer? _gameTimer;

  CityGameBloc(
      {required this.getRandomCity, required AudioManager audioManager})
      : _audioManager = audioManager,
        super(InitialState()) {
    on<LoadCountriesEvent>(_onLoadCountriesEvent);
    on<SelectCountryEvent>(_onSelectCountryEvent);
    on<SelectDifficultyEvent>(_onSelectDifficultyEvent);
    on<StartGameEvent>(_onStartGameEvent);
    on<NextQuestionEvent>(_onNextQuestionEvent);
    on<CheckAnswerEvent>(_onCheckAnswerEvent);
    on<TimerTickEvent>(_onTimerTickEvent);
    on<RestartGameEvent>(_onRestartGameEvent);
  }

  @override
  Future<void> close() {
    _gameTimer?.cancel();
    return super.close();
  }

  void _startTimer(GameStartedState currentState) {
    _gameTimer?.cancel();
    int remaining = currentState.timeRemaining;

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isClosed) {
        // Bloc kapanmadıysa event ekle
        add(TimerTickEvent());
      } else {
        timer.cancel(); // Bloc kapandıysa timer'ı iptal et
      }
    });
  }

  void _onLoadCountriesEvent(
      LoadCountriesEvent event, Emitter<CityGameState> emit) {
    final countries = getRandomCity.repository.getCountries();
    emit(CountrySelectionState(countries: countries));
  }

  void _onSelectCountryEvent(
      SelectCountryEvent event, Emitter<CityGameState> emit) {
    debugPrint("Ülke seçildi: ${event.country}");
    selectedCountry = event.country;
    emit(DifficultySelectionState(selectedCountry: selectedCountry));
  }

  void _onSelectDifficultyEvent(
      SelectDifficultyEvent event, Emitter<CityGameState> emit) {
    debugPrint("Zorluk seviyesi seçildi: ${event.difficulty}");
    selectedDifficulty = event.difficulty;
    add(StartGameEvent(
        country: selectedCountry, difficulty: selectedDifficulty));
  }

  void _onStartGameEvent(
      StartGameEvent event, Emitter<CityGameState> emit) async {
    debugPrint(
        "Oyun başlatılıyor. Ülke: ${event.country}, Zorluk: ${event.difficulty}");
    score = 0;
    currentQuestion = 0;
    selectedCountry = event.country;
    selectedDifficulty = event.difficulty;

    // Zorluk seviyesine göre toplam soru sayısını belirle
    totalQuestions = _getTotalQuestionCount(selectedDifficulty);

    emit(InitialState());
    add(NextQuestionEvent());
  }

  void _onNextQuestionEvent(
      NextQuestionEvent event, Emitter<CityGameState> emit) async {
    if (currentQuestion >= totalQuestions) {
      emit(GameEndedState(
        finalScore: score,
        totalQuestions: totalQuestions,
        selectedCountry: selectedCountry,
        difficulty: selectedDifficulty,
      ));
      return;
    }

    // Ülkeye özgü bir şehir seç
    CityEntity city;
    List<CityEntity> cities =
        getRandomCity.repository.getCitiesInCountry(selectedCountry);

    if (cities.isEmpty) {
      // Eğer seçilen ülkede şehir yoksa, tüm şehirlerden rastgele seç
      cities = getRandomCity.repository.getCities();
      city = cities[Random().nextInt(cities.length)];
    } else {
      city = cities[Random().nextInt(cities.length)];
    }

    // Seçilen şehrin bölgesinden diğer şehirleri bul
    List<CityEntity> regionCities =
        getRandomCity.repository.getCitiesInRegion(city.country, city.region);

    _markers.clear();
    // Şehrin koordinatları boş değilse markeri ekle
    if (city.coordinates.isNotEmpty) {
      _markers.add(Marker(
        markerId: const MarkerId("current"),
        position: city.coordinates[Random().nextInt(city.coordinates.length)],
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ));
    }

    correctCity = city.name;
    currentQuestion++;

    // Zorluk seviyesine göre soru süresi belirle
    int timeLimit = _getTimeLimit(selectedDifficulty);
    List<String> options;

    // Bütün zorluk seviyelerinde bölge bazlı şehirler
    if (regionCities.length > 3) {
      // Yeterli bölge şehri varsa
      options = CityGameUtils.generateRegionBasedOptions(city, cities);
    } else {
      // Yeterli bölge şehri yoksa normal seçenekler
      options = CityGameUtils.generateOptions(city.name, cities);
    }

    final gameState = GameStartedState(
      questionText: "Bu nokta hangi şehirde?",
      options: options,
      markers: _markers,
      score: score,
      totalQuestions: totalQuestions,
      currentQuestion: currentQuestion,
      timeRemaining: timeLimit,
      selectedCountry: selectedCountry,
      difficulty: selectedDifficulty,
    );

    emit(gameState);
    _startTimer(gameState);
  }

  void _onCheckAnswerEvent(
      CheckAnswerEvent event, Emitter<CityGameState> emit) async {
    _gameTimer?.cancel();

    final isCorrect = event.selectedCity == correctCity;
    int pointsEarned = 0;

    if (isCorrect) {
      _audioManager.play(AppSounds.correctAnswer.path);
      // Zorluk seviyesine göre puanlama
      if (state is GameStartedState) {
        final gameState = state as GameStartedState;
        pointsEarned =
            _calculatePoints(gameState.timeRemaining, gameState.difficulty);
        score += pointsEarned;
      }
    } else {
      _audioManager.play(AppSounds.wrongAnswer.path);
    }

    emit(AnswerCheckedState(
      isCorrect: isCorrect,
      feedbackText: isCorrect
          ? "🎉 Doğru! Harikasın! 🎉"
          : "❌ Yanlış! Doğru cevap: $correctCity",
      score: score,
      totalQuestions: totalQuestions,
      currentQuestion: currentQuestion,
      scoreIncrease: pointsEarned,
      selectedCountry: selectedCountry,
      difficulty: selectedDifficulty,
    ));

    await Future.delayed(const Duration(seconds: 2));
    add(NextQuestionEvent());
  }

  void _onTimerTickEvent(TimerTickEvent event, Emitter<CityGameState> emit) {
    if (state is GameStartedState) {
      final currentState = state as GameStartedState;
      if (currentState.timeRemaining > 0) {
        emit(currentState.copyWith(
          timeRemaining: currentState.timeRemaining - 1,
        ));
      } else {
        _gameTimer?.cancel();
        // Süre dolduğunda otomatik olarak yanlış cevap vermiş gibi işle
        add(CheckAnswerEvent(selectedCity: ""));
      }
    }
  }

  void _onRestartGameEvent(
      RestartGameEvent event, Emitter<CityGameState> emit) {
    final countries = getRandomCity.repository.getCountries();
    emit(CountrySelectionState(countries: countries));
  }

  // Puan hesaplama
  int _calculatePoints(int timeRemaining, DifficultyLevel difficulty) {
    int basePoints;

    switch (difficulty) {
      case DifficultyLevel.easy:
        basePoints = 10;
        break;
      case DifficultyLevel.medium:
        basePoints = 20;
        break;
      case DifficultyLevel.hard:
        basePoints = 30;
        break;
      default:
        basePoints = 10;
    }

    // Kalan süreye göre ek puan
    int timeBonus = (timeRemaining / 3).round();

    return basePoints + timeBonus;
  }

  // Zorluk seviyesine göre soru süresi
  int _getTimeLimit(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return 30;
      case DifficultyLevel.medium:
        return 20;
      case DifficultyLevel.hard:
        return 15;
      default:
        return 30;
    }
  }

  // Zorluk seviyesine göre toplam soru sayısı
  int _getTotalQuestionCount(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return 5;
      case DifficultyLevel.medium:
        return 10;
      case DifficultyLevel.hard:
        return 15;
      default:
        return 10;
    }
  }
}
