import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:heartmap/feature/welcome/data/config/welcome_page_config.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/core/utils/enum/app_durations.dart';

class WelcomeAnimatedTitle extends StatelessWidget {
  const WelcomeAnimatedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(
          WelcomePageConfig.title,
          textStyle: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: AppTheme.appColorSheme.onPrimaryContainer),
          textAlign: TextAlign.start,
          speed: AppDurations.fastAnimation.duration,
        ),
      ],
      isRepeatingAnimation: WelcomePageConfig.isRepeatingAnimation,
    );
  }
}
