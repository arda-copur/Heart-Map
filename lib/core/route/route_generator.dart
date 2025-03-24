import 'package:flutter/material.dart';
import 'package:heartmap/feature/home/presentation/pages/home_page.dart';
import 'package:heartmap/feature/welcome/presentation/pages/welcome_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  RouteGenerator._();

  static final RouteGenerator _instance = RouteGenerator._();
  static RouteGenerator get instance => _instance;
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return _createRoute(const WelcomePage());
      case AppRoutes.home:
        return _createRoute(const HomePage());
      default:
        return _createRoute(const Text('Ekran bulunamadı'));
    }
  }

  static PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
