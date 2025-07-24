import 'package:flutter/material.dart';
import 'package:flyer_controler/components/joystick_circle.dart';

/// 摇杆通用抽象父类，封装公共逻辑
abstract class BaseDraggableJoystick extends StatefulWidget {
  final double width;
  final double height;
  final Color baseColor;
  final Color stickColor;
  final double stickRadius;
  final bool isReboundEnabled;
  final Offset? initialStickOffset;

  const BaseDraggableJoystick({
    super.key,
    double? width,
    double? height,
    double size = 200,
    required this.baseColor,
    required this.stickColor,
    this.stickRadius = 30,
    this.isReboundEnabled = true,
    this.initialStickOffset,
  })  : width = width ?? size,
        height = height ?? size;

  /// 限制摇杆偏移的实现（如全向/仅y向）
  Offset limitOffset(Offset offset, double maxOffset);

  /// 构建底座
  Widget buildBase(BuildContext context, double width, double height, double stickRadius);

  /// 处理回调参数
  void onStickChanged(Offset offset, double maxOffset);

  @override
  State<BaseDraggableJoystick> createState() => _BaseDraggableJoystickState();
}

class _BaseDraggableJoystickState extends State<BaseDraggableJoystick> {
  late Offset stickOffset;

  double? _lastDxRatio;
  double? _lastDyRatio;



  @override
  void initState() {
    super.initState();
    stickOffset = widget.initialStickOffset ?? Offset.zero;
  }

  void _updateStick(Offset localPosition) {
    final double maxOffset = (widget.height / 2) - widget.stickRadius;
    final Offset center = Offset(widget.width / 2, widget.height / 2);
    Offset offset = localPosition - center;
    offset = widget.limitOffset(offset, maxOffset);
    setState(() {
      stickOffset = offset;
    });
    final double dx = offset.dx;
    final double dy = offset.dy;
    final bool dxChanged = _lastDxRatio == null || (dx - _lastDxRatio!).abs() > 1e-6;
    final bool dyChanged = _lastDyRatio == null || (dy - _lastDyRatio!).abs() > 1e-6;

    if (dxChanged || dyChanged) {
      _lastDxRatio = dx;
      _lastDyRatio = dy;
      widget.onStickChanged(Offset(dx, -dy), maxOffset);
    }
  }

  void _resetStick() {
    setState(() {
      stickOffset = Offset.zero;
    });
    widget.onStickChanged(Offset.zero, (widget.height / 2) - widget.stickRadius);
  }

  @override
  Widget build(BuildContext context) {
    Offset limitedOffset = widget.limitOffset(stickOffset, (widget.height / 2) - widget.stickRadius);
    return GestureDetector(
      onPanStart: (details) {
        _updateStick(details.localPosition);
      },
      onPanUpdate: (details) {
        _updateStick(details.localPosition);
      },
      onPanEnd: (_) {
        if (widget.isReboundEnabled) {
          _resetStick();
        }
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.buildBase(context, widget.width, widget.height, widget.stickRadius),
            Transform.translate(
              offset: limitedOffset,
              child: buildStick(widget.stickRadius),
            ),
          ],
        ),
      ),
    );
  }

  /// 默认摇杆手柄样式，可被子类覆盖
  Widget buildStick(double stickRadius) {
    return JoystickCircle(
      stickRadius: stickRadius, 
      stickColor: widget.stickColor
    );
  }
} 