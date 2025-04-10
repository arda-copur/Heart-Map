import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heartmap/core/services/audio/audio_manager.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/feature/home/data/datasources/city_data_source.dart';
import 'package:heartmap/feature/home/data/repositories/city_repository_impl.dart';
import 'package:heartmap/feature/home/domain/usecases/get_random_city.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_bloc.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_event.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_state.dart';
import 'package:heartmap/feature/home/presentation/provider/home_view_model.dart';
import 'package:heartmap/feature/home/presentation/widgets/animated_question_builder.dart';
import 'package:heartmap/feature/home/presentation/widgets/confetti_animation.dart';
import 'package:heartmap/feature/home/presentation/widgets/country_selection.dart';
import 'package:heartmap/feature/home/presentation/widgets/custom_map.dart';
import 'package:heartmap/feature/home/presentation/widgets/difficulty_selection.dart';
import 'package:heartmap/feature/home/presentation/widgets/game_over_screen.dart';
import 'package:heartmap/feature/home/presentation/widgets/options.dart';
import 'package:heartmap/feature/home/presentation/widgets/score_timer_display.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => CityGameBloc(
            audioManager: Provider.of<AudioManager>(context, listen: false),
            getRandomCity: GetRandomCity(
              repository: CityRepositoryImpl(dataSource: CityDataSource()),
            ),
          )..add(LoadCountriesEvent()),
          child: BlocListener<CityGameBloc, CityGameState>(
            listener: (context, state) {
              if (state is AnswerCheckedState) {
                if (state.isCorrect) {
                  _viewModel.playConfetti();
                } else {
                  _viewModel.shake();
                }
              }
            },
            child: Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                return BlocBuilder<CityGameBloc, CityGameState>(
                  builder: (context, state) {
                    return Stack(
                      children: [
                        // Harita sadece ülke seçiminden sonra gösterilsin
                        if (!(state is CountrySelectionState ||
                            state is InitialState))
                          CustomMap(
                            markers:
                                state is GameStartedState ? state.markers : {},
                            initialPosition: _getMapInitialPosition(state),
                            onTap: state is GameStartedState ? null : (_) {},
                          ),

                        // Ülke seçim ekranı
                        if (state is CountrySelectionState)
                          CountrySelection(countries: state.countries),

                        // Zorluk seviyesi seçim ekranı
                        if (state is DifficultySelectionState)
                          DifficultySelection(country: state.selectedCountry),

                        // Oyun bitti ekranı
                        if (state is GameEndedState)
                          GameOverScreen(
                            score: state.finalScore,
                            totalQuestions: state.totalQuestions,
                          ),

                        // Oyun aktif ise soru ve süre/skor göster
                        if (state is GameStartedState)
                          Positioned(
                            top: 20,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                ScoreTimerDisplay(
                                  score: state.score,
                                  timeRemaining: state.timeRemaining,
                                  currentQuestion: state.currentQuestion,
                                  totalQuestions: state.totalQuestions,
                                ),
                                const SizedBox(height: 20),
                                AnimatedQuestionBuilder(
                                  questionText: state.questionText,
                                  backgroundColor:
                                      AppTheme.appColorSheme.onErrorContainer,
                                ),
                              ],
                            ),
                          ),

                        // Cevap kontrol edildiğinde geri bildirim
                        if (state is AnswerCheckedState)
                          AnimatedQuestionBuilder(
                            questionText: state.feedbackText,
                            backgroundColor: state.isCorrect
                                ? AppTheme.appColorSheme.onTertiaryContainer
                                : AppTheme.appColorSheme.error,
                          ),

                        // Şıklar
                        if (state is GameStartedState)
                          Options(options: state.options),

                        // Konfeti efekti
                        const ConfettiAnimation(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  LatLng _getMapInitialPosition(CityGameState state) {
    String country = "";

    if (state is GameStartedState) {
      country = state.selectedCountry;
    } else if (state is DifficultySelectionState) {
      country = state.selectedCountry;
    } else if (state is AnswerCheckedState) {
      country = state.selectedCountry;
    } else if (state is GameEndedState) {
      country = state.selectedCountry;
    }

    LatLng position;

    // Ülkeye göre harita konumu
    switch (country) {
      case "Türkiye":
        position = const LatLng(39.0, 35.0);
        break;
      case "Almanya":
        position = const LatLng(51.0, 10.0);
        break;
      case "Fransa":
        position = const LatLng(46.0, 2.0);
        break;
      case "İtalya":
        position = const LatLng(42.0, 12.0);
        break;
      case "İspanya":
        position = const LatLng(40.0, -3.0);
        break;
      default:
        // Herhangi bir ülke seçilmemişse veya bilinmeyen bir ülke ise dünya geneli görünüm
        position = const LatLng(30.0, 10.0);
        break;
    }

    return position;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
