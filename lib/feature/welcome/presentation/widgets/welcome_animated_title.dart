import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heartmap/feature/welcome/data/config/welcome_page_config.dart';
import 'package:heartmap/core/theme/app_theme.dart';

class WelcomeAnimatedTitle extends StatefulWidget {
  const WelcomeAnimatedTitle({super.key});

  @override
  State<WelcomeAnimatedTitle> createState() => _WelcomeAnimatedTitleState();
}

class _WelcomeAnimatedTitleState extends State<WelcomeAnimatedTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _opacityAnimation;

  final List<CharacterAnimation> _characterAnimations = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
    ]).animate(_controller);

    _rotateAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.1, end: 0.1)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.1, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 70,
      ),
    ]).animate(_controller);

    // Create individual character animations
    final random = Random();
    const title = WelcomePageConfig.title;

    for (int i = 0; i < title.length; i++) {
      _characterAnimations.add(
        CharacterAnimation(
          delay: 300 + i * 100 + random.nextInt(100),
          offset: Offset(
            (random.nextDouble() - 0.5) * 50,
            -50 - random.nextDouble() * 50,
          ),
          rotation: (random.nextDouble() - 0.5) * 1.0,
        ),
      );
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = WelcomePageConfig.title;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotateAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.appColorSheme.onPrimaryContainer
                          .withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Colors.amber.shade400,
                      Colors.amber.shade600,
                      Colors.amber.shade800
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ).createShader(bounds),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      min(title.length, _characterAnimations.length),
                      (index) {
                        final charAnim = _characterAnimations[index];
                        final delay = charAnim.delay / 1000.0;
                        final progress = max(
                            0.0,
                            min(1.0,
                                (_controller.value - delay) / (1.0 - delay)));

                        // Calculate the character's position and rotation
                        final offset = Offset(
                          charAnim.offset.dx * (1.0 - progress),
                          charAnim.offset.dy * (1.0 - progress),
                        );
                        final rotation = charAnim.rotation * (1.0 - progress);

                        return Transform.translate(
                          offset: offset,
                          child: Transform.rotate(
                            angle: rotation,
                            child: Opacity(
                              opacity: progress,
                              child: Text(
                                title[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CharacterAnimation {
  final int delay;
  final Offset offset;
  final double rotation;

  CharacterAnimation({
    required this.delay,
    required this.offset,
    required this.rotation,
  });
}
