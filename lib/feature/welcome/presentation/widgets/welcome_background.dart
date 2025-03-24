import 'package:flutter/material.dart';
import 'package:heartmap/core/utils/extension/image_extension.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AnimationImageItems.appBackground.imagePath,
      fit: BoxFit.cover,
    );
  }
}
