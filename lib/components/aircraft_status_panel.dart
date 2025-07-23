import 'package:flutter/material.dart';

/// 飞行器状态数据类型
class AircraftStatus {
  final double batteryVoltage; // 电池电压(V)
  final double batteryCurrent; // 电池电流(A)
  final String controlMode; // 控制模式（手动接管/自动飞行）
  final double totalSpeed; // 飞行总速度(标量, m/s)
  final double roll; // 横滚角(deg)
  final double pitch; // 俯仰角(deg)
  final double yaw; // 偏航角(deg)
  final double? x; // 位置x(可选)
  final double? y; // 位置y(可选)
  final double? z; // 位置z(可选)
  final double flapFrequency; // 扑动频率(Hz)
  final double flapAmplitude; // 扑动幅度
  final double pValue; // 控制器P值
  final double angleOffset; // 控制器角度偏移

  const AircraftStatus({
    required this.batteryVoltage,
    required this.batteryCurrent,
    required this.controlMode,
    required this.totalSpeed,
    required this.roll,
    required this.pitch,
    required this.yaw,
    this.x,
    this.y,
    this.z,
    required this.flapFrequency,
    required this.flapAmplitude,
    required this.pValue,
    required this.angleOffset,
  });
}

/// 飞行器状态显示面板
class AircraftStatusPanel extends StatelessWidget {
  final AircraftStatus status;
  const AircraftStatusPanel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow('电池电压 ', '${status.batteryVoltage.toStringAsFixed(2)} V'),
                _buildRow('电池电流 ', '${status.batteryCurrent.toStringAsFixed(2)} A'),
                _buildRow('控制模式 ', status.controlMode),
                _buildRow('飞行速度 ', '${status.totalSpeed.toStringAsFixed(2)} m/s'),
                _buildRow('Roll ', '${status.roll.toStringAsFixed(1)}°'),
                _buildRow('Pitch ', '${status.pitch.toStringAsFixed(1)}°'),
                _buildRow('Yaw ', '${status.yaw.toStringAsFixed(1)}°'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (status.x != null && status.y != null && status.z != null)
                  _buildRow('位置 ', '(${status.x!.toStringAsFixed(2)}, ${status.y!.toStringAsFixed(2)}, ${status.z!.toStringAsFixed(2)})'),
                _buildRow('扑动频率 ', '${status.flapFrequency.toStringAsFixed(2)} Hz'),
                _buildRow('扑动幅度 ', '${status.flapAmplitude.toStringAsFixed(2)}'),
                _buildRow('P值 ', status.pValue.toStringAsFixed(2)),
                _buildRow('角度偏移 ', status.angleOffset.toStringAsFixed(2)),
              ],
            ),
          ],
        ),

      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
} 