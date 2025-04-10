import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heartmap/core/route/app_routes.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/core/utils/app_dialog.dart';
import 'package:heartmap/core/utils/enum/app_durations.dart';
import 'package:heartmap/feature/welcome/data/config/info_config.dart';
import 'package:heartmap/feature/welcome/data/config/welcome_page_config.dart';
import 'package:heartmap/feature/welcome/presentation/provider/welcome_page_view_model.dart';

class WelcomeButtonMenu extends StatefulWidget {
  final WelcomePageViewModel viewModel;
  const WelcomeButtonMenu({super.key, required this.viewModel});

  @override
  State<WelcomeButtonMenu> createState() => _WelcomeButtonMenuState();
}

class _WelcomeButtonMenuState extends State<WelcomeButtonMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  int? _hoveredButtonIndex;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.buttonsVisible,
      builder: (context, buttonsVisible, child) {
        return AnimatedOpacity(
          duration: AppDurations.extraSlowAnimation.duration,
          opacity: buttonsVisible
              ? WelcomePageConfig.visibleOpacity
              : WelcomePageConfig.notVisibleOpacity,
          child: SlideTransition(
            position: widget.viewModel.buttonAnimation,
            child: Column(
              children: [
                _buildAnimatedButton(
                  index: 0,
                  title: WelcomePageConfig.startGame,
                  icon: Icons.play_arrow_rounded,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                  ),
                  onTap: () => widget.viewModel.isConnected
                      ? widget.viewModel.navigateTo(AppRoutes.home)
                      : widget.viewModel.showNoInternetDialog(context),
                ),
                const SizedBox(height: 16),
                _buildAnimatedButton(
                  index: 1,
                  title: WelcomePageConfig.howToPlay,
                  icon: Icons.help_outline_rounded,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.appColorSheme.onSurfaceVariant,
                      Color.lerp(AppTheme.appColorSheme.onSurfaceVariant,
                          Colors.black, 0.3)!,
                    ],
                  ),
                  onTap: () => AppDialog.show(
                      context: context,
                      title: InfoConfig.infoTitle,
                      message: InfoConfig.gameInfo,
                      confirmText: InfoConfig.confirmButtonText),
                ),
                const SizedBox(height: 16),
                _buildAnimatedButton(
                  index: 2,
                  title: WelcomePageConfig.exit,
                  icon: Icons.exit_to_app_rounded,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.appColorSheme.error,
                      Color.lerp(
                          AppTheme.appColorSheme.error, Colors.black, 0.3)!,
                    ],
                  ),
                  onTap: () => widget.viewModel.exitApp(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedButton({
    required int index,
    required String title,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredButtonIndex = index),
      onExit: (_) => setState(() => _hoveredButtonIndex = null),
      child: GestureDetector(
        onTap: () {
          _playButtonPressAnimation(index);
          Future.delayed(const Duration(milliseconds: 300), onTap);
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: 0.0,
            end: _hoveredButtonIndex == index ? 1.0 : 0.0,
          ),
          duration: const Duration(milliseconds: 200),
          builder: (context, value, child) {
            return Transform.scale(
              scale: 1.0 + value * 0.05,
              child: Container(
                width: 280,
                height: 60,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10 + value * 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2 + value * 0.3),
                    width: 1.5,
                  ),
                ),
                child: Stack(
                  children: [
                    // Particle effects on hover
                    if (value > 0)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CustomPaint(
                            painter: ButtonParticlePainter(
                              progress: value,
                              particleCount: 10,
                            ),
                          ),
                        ),
                      ),

                    // Button content
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            color: Colors.white,
                            size: 24 + value * 4,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18 + value * 2,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 3,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _playButtonPressAnimation(int index) {
    setState(() => _hoveredButtonIndex = index);

    // Add button press animation logic here
    // This could be a quick scale down and up animation
  }
}

class ButtonParticlePainter extends CustomPainter {
  final double progress;
  final int particleCount;
  final Random _random = Random();

  ButtonParticlePainter({
    required this.progress,
    required this.particleCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < particleCount; i++) {
      final paint = Paint()
        ..color =
            Colors.white.withOpacity(0.3 * progress * _random.nextDouble())
        ..style = PaintingStyle.fill;

      final particleSize = _random.nextDouble() * 4 * progress + 1;
      final angle = _random.nextDouble() * 2 * pi;
      final distance = _random.nextDouble() * 30 * progress;

      final x = size.width / 2 + cos(angle) * distance;
      final y = size.height / 2 + sin(angle) * distance;

      canvas.drawCircle(Offset(x, y), particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
