import 'package:flutter/material.dart';
import 'base_draggable_joystick.dart';
import 'package:flyer_controler/utilities/rc_sender.dart';

/// 只能上下移动的虚拟摇杆组件
/// onChanged 回调参数为 dy（相对于底座圆心的y方向偏移比例，范围-1~1）
class VerticalDraggableJoystick extends BaseDraggableJoystick {
  final void Function(double dy)? onChanged;

  const VerticalDraggableJoystick({
    super.key,
    double width = 65,
    double height = 200,
    super.baseColor = const Color(0xFFF0F0F0),
    super.stickColor = Colors.blueAccent,
    this.onChanged,
  }) : super(width: width, height: height);

  @override
  Offset limitOffset(Offset offset, double maxOffset) {
    // 只允许y方向移动，x始终为0
    double dy = offset.dy;
    if (dy.abs() > maxOffset) {
      dy = dy.isNegative ? -maxOffset : maxOffset;
    }
    return Offset(0, dy);
  }

  @override
  Widget buildBase(double width, double height, double stickRadius) {
    return Stack(
      children: [
        // 圆角矩形底座
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: baseColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(width * 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        // 顶部向上箭头
        Positioned(
          top: 8,
          left: 0,
          right: 0,
          child: Icon(Icons.keyboard_arrow_up, color: Colors.blueAccent, size: stickRadius * 1.2),
        ),
        // 底部向下箭头
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent, size: stickRadius * 1.2),
        ),
      ],
    );
  }

  @override
  void onStickChanged(Offset offset, double maxOffset) {
    final double dyRatio = (offset.dy / maxOffset).clamp(-1.0, 1.0);
    onChanged?.call(dyRatio);
    // RC通道范围映射 1000~2000
    int ch2 = (1500 + dyRatio * 500).clamp(1000, 2000).toInt();
    RcSender.updateChannel(2, ch2);
  }
} 