import 'package:flutter/material.dart';

class PressColorButton extends StatefulWidget {
  final Widget child;
  final Color normalColor;
  final Color pressedColor;
  final VoidCallback? onTap; 

  const PressColorButton({
    super.key,
    required this.child,
    required this.normalColor,
    required this.pressedColor,
    this.onTap,
  });

  @override
  State<PressColorButton> createState() => _PressColorButtonState();
}

class _PressColorButtonState extends State<PressColorButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
    );
  }
}