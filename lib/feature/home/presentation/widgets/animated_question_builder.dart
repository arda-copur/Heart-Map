import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heartmap/feature/home/presentation/provider/home_view_model.dart';
import 'package:provider/provider.dart';

class AnimatedQuestionBuilder extends StatefulWidget {
  final String questionText;
  final Color backgroundColor;

  const AnimatedQuestionBuilder({
    super.key,
    required this.questionText,
    required this.backgroundColor,
  });

  @override
  State<AnimatedQuestionBuilder> createState() =>
      _AnimatedQuestionBuilderState();
}

class _AnimatedQuestionBuilderState extends State<AnimatedQuestionBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _floatAnimation = Tween<double>(begin: -3, end: 3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Text opacity animation for subtle text effect
    _textOpacityAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Border radius animation
    _borderAnimation = Tween<double>(begin: 15, end: 25).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return AnimatedBuilder(
      animation:
          Listenable.merge([_animationController, viewModel.shakeController]),
      builder: (context, child) {
        double shakeOffset = 0;
        if (viewModel.shakeController.value > 0) {
          shakeOffset = sin(viewModel.shakeController.value * pi * 8) * 7;
        }

        return Positioned(
          top: 100 + _floatAnimation.value,
          left: 20 + shakeOffset,
          right: 20 - shakeOffset,
          child: Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.backgroundColor,
                    Color.lerp(widget.backgroundColor, Colors.white, 0.2)!,
                  ],
                ),
                borderRadius: BorderRadius.circular(_borderAnimation.value),
                boxShadow: [
                  BoxShadow(
                    color: widget.backgroundColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Opacity(
                opacity: _textOpacityAnimation.value,
                child: Text(
                  widget.questionText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 2,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
