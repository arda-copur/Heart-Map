import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heartmap/feature/home/presentation/provider/home_view_model.dart';
import 'package:provider/provider.dart';

class AnimatedQuestionBuilder extends StatelessWidget {
  final String questionText;
  final Color backgroundColor;

  const AnimatedQuestionBuilder({
    super.key,
    required this.questionText,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return AnimatedBuilder(
      animation: viewModel.shakeController,
      builder: (context, child) {
        double shakeOffset = sin(viewModel.shakeController.value * pi * 10) * 5;
        return Positioned(
          top: 100,
          left: 20 + shakeOffset,
          right: 20 - shakeOffset,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              questionText,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
