import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_bloc.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_event.dart';
import 'package:heartmap/feature/home/presentation/bloc/city_game_state.dart';

class DifficultySelection extends StatefulWidget {
  final String country;

  const DifficultySelection({super.key, required this.country});

  @override
  State<DifficultySelection> createState() => _DifficultySelectionState();
}

class _DifficultySelectionState extends State<DifficultySelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  int? _selectedDifficulty;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectDifficulty(DifficultyLevel difficulty, int index) {
    if (_selectedDifficulty != null) return;

    setState(() {
      _selectedDifficulty = index;
    });

    // Add a delay before triggering the event
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        BlocProvider.of<CityGameBloc>(context).add(
          SelectDifficultyEvent(difficulty: difficulty),
        );
      }
    });
  }

  void _goBackToCountrySelection() {
    setState(() {
      _isExiting = true;
    });

    _animationController.reverse().then((_) {
      if (mounted) {
        BlocProvider.of<CityGameBloc>(context).add(
          LoadCountriesEvent(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Center(
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2C3E50), // Dark blue-gray
                    Color(0xFF1A2530), // Darker blue-gray
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                    spreadRadius: 2,
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with country name

                    // Difficulty selection content
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text(
                            'Zorluk Seviyesi Seçin',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Difficulty buttons with different icons
                          DifficultyButton(
                            index: 0,
                            title: 'Bir deneyelim..',
                            subtitle: '5 Soru - 30 Saniye',
                            icon: Icons.emoji_emotions, // Smiling face
                            color: Colors.green,
                            isSelected: _selectedDifficulty == 0,
                            onTap: () =>
                                _selectDifficulty(DifficultyLevel.easy, 0),
                            animationDelay: 100,
                          ),
                          const SizedBox(height: 16),

                          DifficultyButton(
                            index: 1,
                            title: 'Bence yapabilirim',
                            subtitle: '10 Soru - 20 Saniye',
                            icon: Icons.psychology, // Brain/thinking
                            color: Colors.orange,
                            isSelected: _selectedDifficulty == 1,
                            onTap: () =>
                                _selectDifficulty(DifficultyLevel.medium, 1),
                            animationDelay: 200,
                          ),
                          const SizedBox(height: 16),

                          DifficultyButton(
                            index: 2,
                            title: "Ben Piri Reis'im!",
                            subtitle: '15 Soru - 15 Saniye',
                            icon: Icons.workspace_premium, // Trophy/award
                            color: Colors.red,
                            isSelected: _selectedDifficulty == 2,
                            onTap: () =>
                                _selectDifficulty(DifficultyLevel.hard, 2),
                            animationDelay: 300,
                          ),

                          const SizedBox(height: 30),

                          // Enhanced back button
                          AnimatedOpacity(
                            opacity: _selectedDifficulty != null ? 0.5 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF3498DB), // Blue
                                    Color(0xFF2980B9), // Darker blue
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF3498DB)
                                        .withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _selectedDifficulty != null
                                      ? null
                                      : _goBackToCountrySelection,
                                  borderRadius: BorderRadius.circular(30),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.map,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Ülke Seçimine Dön',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

class DifficultyButton extends StatefulWidget {
  final int index;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final int animationDelay;

  const DifficultyButton({
    Key? key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.animationDelay,
  }) : super(key: key);

  @override
  State<DifficultyButton> createState() => _DifficultyButtonState();
}

class _DifficultyButtonState extends State<DifficultyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation; // Separate opacity animation
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    // Dedicated opacity animation that stays within 0-1
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Delayed entrance animation
    Future.delayed(Duration(milliseconds: widget.animationDelay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.color;
    final darkColor = HSLColor.fromColor(baseColor)
        .withLightness(
            (HSLColor.fromColor(baseColor).lightness - 0.15).clamp(0.0, 1.0))
        .toColor();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: Opacity(
            opacity: _opacityAnimation.value, // Use dedicated opacity animation
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedScale(
                  scale: widget.isSelected
                      ? 1.05
                      : _isHovered
                          ? 1.03
                          : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: widget.isSelected
                              ? [
                                  baseColor,
                                  darkColor,
                                ]
                              : [
                                  baseColor.withOpacity(1),
                                  darkColor.withOpacity(1),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: baseColor.withOpacity(widget.isSelected
                                ? 0.5
                                : _isHovered
                                    ? 0.3
                                    : 0.2),
                            blurRadius: widget.isSelected
                                ? 15
                                : _isHovered
                                    ? 10
                                    : 5,
                            offset: Offset(
                                0,
                                widget.isSelected
                                    ? 5
                                    : _isHovered
                                        ? 3
                                        : 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            // Difficulty icon
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: darkColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: widget.isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : Icon(
                                        widget.icon,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Difficulty text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.subtitle,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Arrow indicator
                            AnimatedOpacity(
                              opacity:
                                  _isHovered || widget.isSelected ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                widget.isSelected
                                    ? Icons.check_circle_outline
                                    : Icons.arrow_forward,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
