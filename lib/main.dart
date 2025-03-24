import 'package:flutter/material.dart';
import 'package:heartmap/core/config/app_config.dart';
import 'package:heartmap/core/init/app_init.dart';
import 'package:heartmap/core/route/app_routes.dart';
import 'package:heartmap/core/route/navigation_service.dart';
import 'package:heartmap/core/route/route_generator.dart';
import 'package:heartmap/core/theme/app_theme.dart';

void main() {
  AppInit.initializeApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appTitle,
      theme: AppTheme.appTheme,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.welcome,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: AppConfig.appBanner,
    );
  }
}
