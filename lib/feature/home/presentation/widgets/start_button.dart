import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/core/widgets/custom_animated_button.dart.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_bloc.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_event.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomAnimatedButton(
        onTap: () => context.read<CityGameBloc>().add(StartGameEvent()),
        title: 'Oyunu Başlat',
        textStyle: Theme.of(context).textTheme.bodyLarge,
        bgColor: AppTheme.appColorSheme.secondaryContainer,
      ),
    );
  }
}
