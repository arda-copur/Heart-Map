import 'package:flutter/material.dart';
import 'package:heartmap/core/theme/app_theme.dart';

class ChooseTabbar extends StatelessWidget {
  const ChooseTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: PrimaryContainer(
          color: AppTheme.appColorSheme.primary,
          radius: 10,
          child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppTheme.appColorSheme.secondary,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    AppTheme.appColorSheme.secondary,
                    AppTheme.appColorSheme.primary,
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
              tabs: const [
                Tab(
                  text: 'Kolay',
                ),
                Tab(
                  text: 'Orta',
                ),
                Tab(
                  text: 'Zor',
                ),
              ]),
        ));
  }
}

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;
  const PrimaryContainer({
    super.key,
    this.radius,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 30),
        boxShadow: [
          BoxShadow(
            color: color ?? const Color(0XFF1E1E1E),
          ),
          BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0,
            color: AppTheme.appColorSheme.inversePrimary,
          ),
        ],
      ),
      child: child,
    );
  }
}
