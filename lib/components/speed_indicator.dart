import 'package:flutter/material.dart';

class SpeedIndicator extends StatelessWidget {
  final double progress; // 0.0 ~ 1.0
  final Color filledColor;
  final Color unfilledColor;
  final double blockWidth;
  final double blockSpacing;

  const SpeedIndicator({
    required this.progress,
    this.filledColor = const Color(0xFF4F8CFF),
    this.unfilledColor = Colors.grey,
    this.blockWidth = 13.0,
    this.blockSpacing = 4.0,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    // 计算高亮方块数量
    final int filledBlocks = (progress * 20).round();
    final int speed = (progress * 100).toInt();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: List.generate(20, (index) {
            return Column(
              children: [
                Container(
                  width: blockWidth,
                  height: blockWidth*0.5,
                  margin: EdgeInsets.only(top: blockSpacing),
                  decoration: BoxDecoration(
                    color: index+1 > 20 - filledBlocks ? filledColor : unfilledColor,
                  ),
                ),
              ],
            );
          }),
        ),
        Text('${speed}%',
          style: TextStyle(fontSize: 15),),
      ],
    );
  }
}