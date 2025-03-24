import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/core/widgets/custom_animated_button.dart.dart';

import 'package:heartmap/feature/home/presentation/bloc/city_game_bloc.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_event.dart';

class Options extends StatelessWidget {
  final List<String> options;

  const Options({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Column(
        children: options.map((option) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CustomAnimatedButton(
              onTap: () {
                context.read<CityGameBloc>().add(
                      CheckAnswerEvent(selectedCity: option),
                    );
              },
              title: option,
              textStyle: Theme.of(context).textTheme.bodyLarge,
              bgColor: AppTheme.appColorSheme.inverseSurface
            ),
          );
        }).toList(),
      ),
    );
  }
}
