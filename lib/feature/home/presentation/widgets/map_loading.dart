import 'package:flutter/material.dart';
import 'package:heartmap/core/utils/extension/image_extension.dart';

class MapLoading extends StatelessWidget {
  const MapLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(AnimationImageItems.appLoading.imagePath),
        ),
        Text(
          'Yükleniyor...',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
