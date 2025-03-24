import 'package:flutter/material.dart';
import 'package:heartmap/core/utils/enum/app_durations.dart';

class ReverseButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const ReverseButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  State<ReverseButton> createState() => _ReverseButtonState();
}

class _ReverseButtonState extends State<ReverseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppDurations.fastAnimation.duration,
      lowerBound: 0.9,
      upperBound: 1.0,
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.reverse(),
      onTapUp: (_) {
        _animationController.forward();
        widget.onPressed();
      },
      onTapCancel: () => _animationController.forward(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor,
          ),
          child: Text(
            widget.text,
            style: TextStyle(color: widget.textColor),
          ),
        ),
      ),
    );
  }
}
