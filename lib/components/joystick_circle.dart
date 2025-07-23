import 'package:flutter/material.dart';

class JoystickCircle extends StatelessWidget {
  const JoystickCircle({super.key, required this.stickRadius, required this.stickColor});

  final double stickRadius;
  final Color stickColor;

  @override
  Widget build(BuildContext context) {
    return Container(
                width: stickRadius * 2,
                height: stickRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF4F8CFF), Color(0xFFB36AFF)], // 蓝到紫
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: stickColor.withAlpha((0.2*255).toInt()),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              );
  }
}