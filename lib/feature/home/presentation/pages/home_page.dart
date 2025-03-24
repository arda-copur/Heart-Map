import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:heartmap/feature/home/presentation/widgets/custom_map.dart';
import 'package:heartmap/feature/home/presentation/widgets/map_loading.dart';
import 'package:heartmap/feature/home/presentation/widgets/options.dart';
import 'package:heartmap/feature/home/presentation/widgets/start_button.dart';
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
          ),
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
                    String questionText;
                    Color backgroundColor;
                    bool showOptions = state is GameStartedState;

                    if (state is GameStartedState) {
                      questionText = state.questionText;
                      backgroundColor = AppTheme.appColorSheme.onInverseSurface;
                    } else if (state is AnswerCheckedState) {
                      questionText = state.feedbackText;
                      backgroundColor = state.isCorrect
                          ? AppTheme.appColorSheme.onTertiaryContainer
                          : AppTheme.appColorSheme.error;
                    } else {
                      questionText = "Başlamak için butona bas!";
                      backgroundColor = Theme.of(context).colorScheme.primary;
                    }

                    return Stack(
                      children: [
                        if (!viewModel.isMapLoaded) const MapLoading(),
                        CustomMap(
                          markers:
                              state is GameStartedState ? state.markers : {},
                          onTap: (_) {
                            if (state is InitialState ||
                                state is GameEndedState) {
                              context
                                  .read<CityGameBloc>()
                                  .add(StartGameEvent());
                            }
                          },
                        ),
                        if (state is InitialState || state is GameEndedState)
                          const StartButton(),
                        if (state is GameStartedState ||
                            state is AnswerCheckedState)
                          AnimatedQuestionBuilder(
                            questionText: questionText,
                            backgroundColor: backgroundColor,
                          ),
                        if (showOptions) Options(options: state.options),
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

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
