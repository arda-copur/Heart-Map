import 'package:flutter/material.dart';

class CustomAnimatedButton extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;
  final double? fontSize;
  final IconData? iconData;
  final TextStyle? textStyle;
  final Color? textColor, bgColor;
  const CustomAnimatedButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.width,
      this.height,
      this.elevation = 5,
      this.borderRadius,
      this.fontSize,
      this.textColor,
      this.bgColor,
      this.iconData,
      this.textStyle})
      : super(key: key);

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: widget.elevation ?? 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
            ),
            child: Text(widget.title, style: widget.textStyle),
          ),
        ),
      ),
    );
  }
}
