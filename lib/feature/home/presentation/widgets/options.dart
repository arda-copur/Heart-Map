import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heartmap/core/theme/app_theme.dart';
import 'package:heartmap/core/utils/extension/context_extension.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_bloc.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_event.dart';

class Options extends StatefulWidget {
  final List<String> options;

  const Options({super.key, required this.options});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> with SingleTickerProviderStateMixin {
  int? _hoveredIndex;
  int? _selectedIndex;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              widget.options.length,
              (index) => OptionItem(
                option: widget.options[index],
                index: index,
                isHovered: _hoveredIndex == index,
                onHover: (isHovered) {
                  if (_selectedIndex == null) {
                    setState(() {
                      _hoveredIndex = isHovered ? index : null;
                    });
                  }
                },
                onTap: () {
                  if (_selectedIndex != null) {
                    return; // Prevent multiple selections
                  }

                  setState(() {
                    _selectedIndex = index;
                    _hoveredIndex = null;
                  });

                  // Add a 1-second delay before triggering the event
                  Future.delayed(const Duration(seconds: 1), () {
                    if (mounted) {
                      context.read<CityGameBloc>().add(
                            CheckAnswerEvent(
                                selectedCity: widget.options[index]),
                          );
                    }
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class OptionItem extends StatefulWidget {
  final String option;
  final int index;
  final bool isHovered;
  final Function(bool) onHover;
  final VoidCallback onTap;

  const OptionItem({
    Key? key,
    required this.option,
    required this.index,
    required this.isHovered,
    required this.onHover,
    required this.onTap,
  }) : super(key: key);

  @override
  State<OptionItem> createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Staggered entrance animation
    Future.delayed(Duration(milliseconds: 100 * widget.index), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void didUpdateWidget(OptionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isHovered != oldWidget.isHovered) {
      if (widget.isHovered) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Generate a color based on the index
    final baseColor = AppTheme.appColorSheme.onErrorContainer;
    final letterCircleColor = HSLColor.fromColor(baseColor)
        .withLightness(
            (HSLColor.fromColor(baseColor).lightness - 0.2).clamp(0.0, 1.0))
        .toColor();

    // Option letters for multiple choice (A, B, C, D, etc.)
    final optionLetter =
        String.fromCharCode(65 + widget.index); // A, B, C, D...

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 10.0), // Reduced bottom padding
            child: InkWell(
              onTap: () {
                if (!_isSelected) {
                  setState(() {
                    _isSelected = true;
                  });
                  widget.onTap();
                }
              },
              onHover: (isHovered) {
                if (!_isSelected) {
                  widget.onHover(isHovered);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _isSelected
                        ? [
                            Colors.amber.shade600,
                            Colors.amber.shade400,
                          ]
                        : [
                            baseColor,
                            Color.lerp(baseColor, Colors.white, 0.2)!,
                          ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: _isSelected
                          ? Colors.amber.withOpacity(0.4)
                          : baseColor.withOpacity(0.3),
                      blurRadius: _isSelected || widget.isHovered ? 15 : 8,
                      offset:
                          Offset(0, _isSelected || widget.isHovered ? 5 : 3),
                      spreadRadius: _isSelected || widget.isHovered ? 1 : 0,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(
                        _isSelected || widget.isHovered ? 0.3 : 0.1),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    // Option letter circle (A, B, C, D)
                    Container(
                      width: 34, // Reduced size
                      height: 34, // Reduced size
                      margin: const EdgeInsets.all(8), // Reduced margin
                      decoration: BoxDecoration(
                        color: _isSelected
                            ? Colors.amber.shade400
                            : letterCircleColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              )
                            : Text(
                                optionLetter,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16, // Smaller font
                                ),
                              ),
                      ),
                    ),
                    // Option text
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8), // Reduced padding
                        child: Text(
                          widget.option,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16, // Smaller font
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Right arrow or check indicator
                    AnimatedOpacity(
                      opacity: widget.isHovered || _isSelected ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        margin: const EdgeInsets.all(12), // Reduced margin
                        child: _isSelected
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                                size: 18,
                              )
                            : Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white.withOpacity(0.7),
                                size: 16, // Smaller icon
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
