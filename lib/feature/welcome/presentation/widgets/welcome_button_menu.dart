import 'package:flutter/material.dart';
import 'package:heartmap/core/route/app_routes.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/core/utils/app_dialog.dart';
import 'package:heartmap/core/utils/enum/app_durations.dart';
import 'package:heartmap/core/widgets/custom_animated_button.dart.dart';
import 'package:heartmap/feature/welcome/data/config/info_config.dart';
import 'package:heartmap/feature/welcome/data/config/welcome_page_config.dart';
import 'package:heartmap/feature/welcome/presentation/provider/welcome_page_view_model.dart';

class WelcomeButtonMenu extends StatelessWidget {
  final WelcomePageViewModel viewModel;
  const WelcomeButtonMenu({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.buttonsVisible,
      builder: (context, buttonsVisible, child) {
        return AnimatedOpacity(
          duration: AppDurations.extraSlowAnimation.duration,
          opacity: buttonsVisible
              ? WelcomePageConfig.visibleOpacity
              : WelcomePageConfig.notVisibleOpacity,
          child: SlideTransition(
            position: viewModel.buttonAnimation,
            child: Column(
              children: [
                CustomAnimatedButton(
                  onTap: () => viewModel.isConnected
                      ? viewModel.navigateTo(AppRoutes.home)
                      : viewModel.showNoInternetDialog(context),
                  title: WelcomePageConfig.startGame,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                CustomAnimatedButton(
                  onTap: () => AppDialog.show(
                      context: context,
                      title: InfoConfig.infoTitle,
                      message: InfoConfig.gameInfo,
                      confirmText: InfoConfig.confirmButtonText),
                  title: WelcomePageConfig.howToPlay,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  bgColor: AppTheme.appColorSheme.onSurfaceVariant,
                ),
                const SizedBox(height: 10),
                CustomAnimatedButton(
                  onTap: () => viewModel.exitApp(),
                  title: WelcomePageConfig.exit,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  bgColor: AppTheme.appColorSheme.error,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
