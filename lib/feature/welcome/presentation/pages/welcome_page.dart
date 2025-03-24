import 'package:flutter/material.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/feature/welcome/presentation/provider/welcome_page_view_model.dart';
import 'package:heartmap/feature/welcome/presentation/widgets/welcome_animated_title.dart';
import 'package:heartmap/feature/welcome/presentation/widgets/welcome_background.dart';
import 'package:heartmap/feature/welcome/presentation/widgets/welcome_button_menu.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late WelcomePageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = WelcomePageViewModel();
    _viewModel.playMenuSound();
    _viewModel.initializeButtonAnimation(this);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const WelcomeBackground(),
          Padding(
            padding: AppTheme.topPrimaryPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const WelcomeAnimatedTitle(),
                WelcomeButtonMenu(viewModel: _viewModel),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
