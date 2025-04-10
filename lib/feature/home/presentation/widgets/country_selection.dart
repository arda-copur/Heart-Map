import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/core/utils/extension/context_extension.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_bloc.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_event.dart';

class CountrySelection extends StatefulWidget {
  final List<String> countries;

  const CountrySelection({super.key, required this.countries});

  @override
  State<CountrySelection> createState() => _CountrySelectionState();
}

class _CountrySelectionState extends State<CountrySelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  int? _hoveredIndex;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectCountry(String country, int index) {
    if (_selectedIndex != null) return;

    setState(() {
      _selectedIndex = index;
      _hoveredIndex = null;
    });

    // Add a delay before triggering the event
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        BlocProvider.of<CityGameBloc>(context).add(
          SelectCountryEvent(country: country),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Card(
            elevation: 20,
            shadowColor: AppTheme.appColorSheme.primary.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.appColorSheme.surface,
                    AppTheme.appColorSheme.surface.withOpacity(0.9),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        AppTheme.appColorSheme.onErrorContainer,
                        AppTheme.appColorSheme.error,
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      'Hangi Ülkede Oynamak İstersiniz?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 200,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.appColorSheme.onErrorContainer,
                          AppTheme.appColorSheme.error,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: context.dynamicHeight(0.7),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.countries.length,
                      itemBuilder: (context, index) {
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 400 + (index * 100)),
                          curve: Curves.easeOutQuart,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 50 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: MouseRegion(
                              onEnter: (_) {
                                if (_selectedIndex == null) {
                                  setState(() => _hoveredIndex = index);
                                }
                              },
                              onExit: (_) {
                                if (_selectedIndex == null) {
                                  setState(() => _hoveredIndex = null);
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                transform: Matrix4.identity()
                                  ..scale(_hoveredIndex == index ? 1.03 : 1.0),
                                child: CountryButton(
                                  country: widget.countries[index],
                                  isHovered: _hoveredIndex == index,
                                  isSelected: _selectedIndex == index,
                                  selectedIndex: _selectedIndex,
                                  onTap: () => _selectCountry(
                                      widget.countries[index], index),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CountryButton extends StatefulWidget {
  final String country;
  final bool isHovered;
  final bool isSelected;
  final int? selectedIndex;
  final VoidCallback onTap;

  const CountryButton({
    required this.country,
    required this.isHovered,
    required this.isSelected,
    required this.selectedIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<CountryButton> createState() => _CountryButtonState();
}

class _CountryButtonState extends State<CountryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _selectionController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _selectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.08)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.08, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.05)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 30,
      ),
    ]).animate(_selectionController);

    _glowAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.2, end: 0.6)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.6, end: 0.3)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.3, end: 0.5)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 30,
      ),
    ]).animate(_selectionController);

    _slideAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -10)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -10, end: 5)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 5, end: 0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 30,
      ),
    ]).animate(_selectionController);
  }

  @override
  void didUpdateWidget(CountryButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Start selection animation when this button is selected
    if (widget.isSelected && !oldWidget.isSelected) {
      _selectionController.forward(from: 0.0);
    }

    // Reset selection animation when another button is selected
    if (!widget.isSelected && oldWidget.isSelected) {
      _selectionController.stop();
    }
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if this button should be dimmed (when another is selected)
    final bool shouldDim = widget.selectedIndex != null && !widget.isSelected;

    return AnimatedBuilder(
      animation: _selectionController,
      builder: (context, child) {
        return Transform.translate(
          offset: widget.isSelected
              ? Offset(_slideAnimation.value, 0)
              : Offset.zero,
          child: Transform.scale(
            scale: widget.isSelected ? _pulseAnimation.value : 1.0,
            child: GestureDetector(
              onTap: widget.selectedIndex == null ? widget.onTap : null,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: shouldDim ? 0.5 : 1.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.isSelected
                          ? [
                              AppTheme.appColorSheme.onErrorContainer,
                              AppTheme.appColorSheme.error,
                            ]
                          : widget.isHovered
                              ? [
                                  AppTheme.appColorSheme.onErrorContainer,
                                  AppTheme.appColorSheme.error,
                                ]
                              : [
                                  AppTheme.appColorSheme.onErrorContainer
                                      .withOpacity(0.8),
                                  AppTheme.appColorSheme.error,
                                ],
                    ),
                    boxShadow: widget.isSelected
                        ? [
                            BoxShadow(
                              color: AppTheme.appColorSheme.onErrorContainer
                                  .withOpacity(_glowAnimation.value),
                              blurRadius: 20,
                              spreadRadius: 4,
                            ),
                            BoxShadow(
                              color: AppTheme.appColorSheme.onErrorContainer
                                  .withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : widget.isHovered
                            ? [
                                BoxShadow(
                                  color: AppTheme.appColorSheme.onErrorContainer
                                      .withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                )
                              ],
                    border: widget.isSelected
                        ? Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 2.0,
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      // Country flag or icon could be added here
                      widget.isSelected
                          ? Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          : const SizedBox(width: 0),
                      Expanded(
                        child: Text(
                          widget.country,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: widget.isSelected || widget.isHovered
                                ? FontWeight.bold
                                : FontWeight.w300,
                            color: widget.isSelected || widget.isHovered
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyLarge?.color,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: widget.isSelected
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                                size: 24,
                              )
                            : Icon(
                                Icons.arrow_forward_ios,
                                color: widget.isHovered
                                    ? Colors.white
                                    : AppTheme.appColorSheme.onInverseSurface
                                        .withOpacity(0.5),
                                size: widget.isHovered ? 20 : 16,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
