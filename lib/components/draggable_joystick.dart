import 'package:flutter/material.dart';
import 'base_draggable_joystick.dart';
import 'package:flyer_controler/utilities/rc_sender.dart';

/// 可拖动的圆形摇杆组件，允许x/y方向移动
/// onChanged 回调参数为 (dx, dy) 相对于底座圆心的偏移比例，范围 -1~1
class DraggableJoystick extends BaseDraggableJoystick {
  final void Function(double dx, double dy)? onChanged;

  const DraggableJoystick({
    super.key,
    super.size = 145,
    super.baseColor = const Color(0xFFF0F0F0),
    super.stickColor = Colors.blueAccent,
    this.onChanged,
  });

  @override
  Offset limitOffset(Offset offset, double maxOffset) {
    // 限制在圆形区域内
    if (offset.distance > maxOffset) {
      return Offset.fromDirection(offset.direction, maxOffset);
    }
    return offset;
  }

  @override
  Widget buildBase(BuildContext context, double width, double height, double stickRadius) {
    return Container(
      width: width * 0.8,
      height: height * 0.8,
      decoration: BoxDecoration(
        color: baseColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }

  @override
  void onStickChanged(Offset offset, double maxOffset) {
    final double dxRatio = (offset.dx / maxOffset).clamp(-1.0, 1.0);
    final double dyRatio = (offset.dy / maxOffset).clamp(-1.0, 1.0);
    onChanged?.call(dxRatio, dyRatio);
  }
} 