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

    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: viewModel.confettiController,
        blastDirection: pi / 2,
        shouldLoop: false,
        emissionFrequency: 0.05,
        numberOfParticles: 30,
        gravity: 0.3,
      ),
    );
  }
}
