import 'dart:math';
import 'package:flutter/material.dart';

/// 半圆形方位指示条组件
/// 由60个小长方形组成，angle参数控制高亮数量
class AngleIndicator extends StatefulWidget {
  /// 初始角度，范围0~180
  final double initialAngle;
  /// 方块总数，默认60
  final int blockCount;
  /// 半径
  final double radius;
  /// 方块宽度
  final double blockWidth;
  /// 高亮色
  final Color activeColor;
  /// 未激活色
  final Color inactiveColor;

  const AngleIndicator({
    super.key,
    required this.initialAngle,
    this.blockCount = 60,
    this.radius = 90,
    this.blockWidth = 11,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  });

  @override
  State<AngleIndicator> createState() => _SemiCircleDirectionBarState();
}

class _SemiCircleDirectionBarState extends State<AngleIndicator> {
  late double angle;

  @override
  void initState() {
    super.initState();
    angle = widget.initialAngle;
  }

  /// 动态设置方位角，范围-180~180
  void setAngle(double newAngle) {
    setState(() {
      angle = newAngle.clamp(0, 180);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double blockHeight = widget.blockWidth * 0.5;
    // 每个方块代表的角度
    final double anglePerBlock = 360 / widget.blockCount;
    // 0度为最左侧，90度为最上方，180度为最右侧
    final int activeIndex = ((angle + 180) / anglePerBlock).round() % widget.blockCount;
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius + blockHeight,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(widget.blockCount, (i) {
          final double blockAngle = i * anglePerBlock;
          final double rad = blockAngle * pi / 180;
          final bool isActive = i == activeIndex;
          return Transform.translate(
            offset: Offset(
              widget.radius * cos(rad),
              widget.radius * sin(rad),
            ),
            child: Transform.rotate(
              angle: rad,
              child: Container(
                width: widget.blockWidth,
                height: blockHeight,
                decoration: BoxDecoration(
                  color: isActive ? widget.activeColor : widget.inactiveColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
} 