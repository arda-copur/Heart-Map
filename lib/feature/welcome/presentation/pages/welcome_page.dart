import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/feature/welcome/presentation/provider/welcome_page_view_model.dart';
import 'package:heartmap/feature/welcome/presentation/widgets/welcome_animated_title.dart';
import 'package:heartmap/feature/welcome/presentation/widgets/welcome_button_menu.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late WelcomePageViewModel _viewModel;
  late AnimationController _backgroundController;
  late AnimationController _particleController;
  late AnimationController _mapElementsController;

  final List<MapElement> _mapElements = [];
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _viewModel = WelcomePageViewModel();
    _viewModel.playMenuSound();
    _viewModel.initializeButtonAnimation(this);

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 30000),
    )..repeat();

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();

    _mapElementsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    )..repeat();

    _createMapElements();

    _createParticles();
  }

  void _createMapElements() {
    final random = Random();

    _mapElements.add(
      MapElement(
        icon: Icons.explore,
        size: 40,
        position: Offset(
            random.nextDouble() * 0.8 + 0.1, random.nextDouble() * 0.3 + 0.1),
        rotationSpeed: 0.001,
        floatSpeed: 0.5 + random.nextDouble() * 0.5,
        color: Colors.amber,
      ),
    );

    _mapElements.add(
      MapElement(
        icon: Icons.place,
        size: 35,
        position: Offset(
            random.nextDouble() * 0.8 + 0.1, random.nextDouble() * 0.3 + 0.6),
        rotationSpeed: 0,
        floatSpeed: 0.3 + random.nextDouble() * 0.5,
        color: Colors.redAccent,
      ),
    );

    _mapElements.add(
      MapElement(
        icon: Icons.public,
        size: 45,
        position: Offset(
            random.nextDouble() * 0.8 + 0.1, random.nextDouble() * 0.3 + 0.3),
        rotationSpeed: 0.002,
        floatSpeed: 0.4 + random.nextDouble() * 0.5,
        color: Colors.lightBlueAccent,
      ),
    );

    _mapElements.add(
      MapElement(
        icon: Icons.map,
        size: 38,
        position: Offset(
            random.nextDouble() * 0.8 + 0.1, random.nextDouble() * 0.3 + 0.5),
        rotationSpeed: 0.0005,
        floatSpeed: 0.6 + random.nextDouble() * 0.5,
        color: Colors.greenAccent,
      ),
    );
  }

  void _createParticles() {
    final random = Random();

    for (int i = 0; i < 30; i++) {
      _particles.add(
        Particle(
          position: Offset(
            random.nextDouble(),
            random.nextDouble(),
          ),
          speed: Offset(
            (random.nextDouble() - 0.5) * 0.02,
            (random.nextDouble() - 0.5) * 0.02,
          ),
          size: random.nextDouble() * 4 + 1,
          color: Colors.white.withOpacity(random.nextDouble() * 0.5 + 0.1),
        ),
      );
    }
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _particleController.dispose();
    _mapElementsController.dispose();
    super.dispose();
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      HSVColor.fromAHSV(
                        1.0,
                        (_backgroundController.value * 360) % 360,
                        0.7,
                        0.2,
                      ).toColor(),
                      HSVColor.fromAHSV(
                        1.0,
                        ((_backgroundController.value * 360) + 60) % 360,
                        0.8,
                        0.3,
                      ).toColor(),
                    ],
                  ),
                ),
              );
            },
          ),

          CustomPaint(
            size: Size(size.width, size.height),
            painter: MapGridPainter(),
          ),

          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              for (var particle in _particles) {
                particle.position += particle.speed;

                if (particle.position.dx < 0) {
                  particle.position = Offset(1, particle.position.dy);
                }
                if (particle.position.dx > 1) {
                  particle.position = Offset(0, particle.position.dy);
                }
                if (particle.position.dy < 0) {
                  particle.position = Offset(particle.position.dx, 1);
                }
                if (particle.position.dy > 1) {
                  particle.position = Offset(particle.position.dx, 0);
                }
              }

              return CustomPaint(
                size: Size(size.width, size.height),
                painter: ParticlePainter(particles: _particles),
              );
            },
          ),

          AnimatedBuilder(
            animation: _mapElementsController,
            builder: (context, child) {
              return Stack(
                children: _mapElements.map((element) {
                  final float = sin(_mapElementsController.value *
                          2 *
                          pi *
                          element.floatSpeed) *
                      10;

                  final rotation = _mapElementsController.value *
                      2 *
                      pi *
                      element.rotationSpeed;

                  return Positioned(
                    left: element.position.dx * size.width,
                    top: element.position.dy * size.height + float,
                    child: Transform.rotate(
                      angle: rotation,
                      child: Icon(
                        element.icon,
                        size: element.size,
                        color: element.color.withOpacity(0.7),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          SafeArea(
            child: Padding(
              padding: AppTheme.topPrimaryPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WelcomeAnimatedTitle(),
                  const SizedBox(height: 40),
                  Center(child: WelcomeButtonMenu(viewModel: _viewModel)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Map grid painter
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 20; i++) {
      final y = size.height * i / 20;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    for (int i = 0; i < 20; i++) {
      final x = size.width * i / 20;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    for (int i = 1; i <= 5; i++) {
      final radius = size.width * i / 10;
      canvas.drawCircle(Offset(centerX, centerY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(
          particle.position.dx * size.width,
          particle.position.dy * size.height,
        ),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MapElement {
  final IconData icon;
  final double size;
  Offset position;
  final double rotationSpeed;
  final double floatSpeed;
  final Color color;

  MapElement({
    required this.icon,
    required this.size,
    required this.position,
    required this.rotationSpeed,
    required this.floatSpeed,
    required this.color,
  });
}

class Particle {
  Offset position;
  final Offset speed;
  final double size;
  final Color color;

  Particle({
    required this.position,
    required this.speed,
    required this.size,
    required this.color,
  });
}
