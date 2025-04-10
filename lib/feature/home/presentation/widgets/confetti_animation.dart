import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:heartmap/feature/home/presentation/provider/home_view_model.dart';
import 'package:provider/provider.dart';

class ConfettiAnimation extends StatelessWidget {
  const ConfettiAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    if (viewModel.confettiController.state ==
        ConfettiControllerState.disposed) {
      return const SizedBox
          .shrink(); // Eğer controller dispose edilmişse boş widget döndür
    }

    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: viewModel.confettiController,
        blastDirection: pi / 2,
        shouldLoop: false,
        emissionFrequency: 0.1,
        numberOfParticles: 50,
        gravity: 0.2,
        maxBlastForce: 10,
        minBlastForce: 5,
        particleDrag: 0.05,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple,
          Colors.red,
        ],
      ),
    );
  }
}
