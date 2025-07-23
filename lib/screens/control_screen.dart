import 'package:flutter/material.dart';
import 'package:flyer_controler/components/device_scan_dialog.dart';
import 'package:flyer_controler/components/press_button.dart';
import 'package:flyer_controler/components/draggable_joystick.dart';
import 'package:flyer_controler/components/vertical_draggable_joystick.dart';
import 'package:flyer_controler/components/angle_indicator.dart';
import 'package:flyer_controler/components/speed_indicator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flyer_controler/components/aircraft_status_panel.dart';
import 'package:flyer_controler/components/control_app_bar.dart';
import 'package:flyer_controler/utilities/rc_sender.dart';
import 'package:flyer_controler/utilities/constants.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  double verticalValue = 0.5;
  double horizontalValue = 0.5;
  double semiCircleAngle = 90;
  bool isUdpConnected = false;

  void increaseVertical() {
    setState(() {
      verticalValue = (verticalValue + 0.05).clamp(0.0, 1.0);
    });
  }

  void decreaseVertical() {
    setState(() {
      verticalValue = (verticalValue - 0.05).clamp(0.0, 1.0);
    });
  }

  void increaseHorizontal() {
    setState(() {
      horizontalValue = (horizontalValue + 0.05).clamp(0.0, 1.0);
    });
  }

  void decreaseHorizontal() {
    setState(() {
      horizontalValue = (horizontalValue - 0.05).clamp(0.0, 1.0);
    });
  }

  void setSemiCircleAngle(double value) {
    setState(() {
      semiCircleAngle = value;
    });
  }
  
  void _onWifiButtonPressed(BuildContext context) async {
    final info = NetworkInfo();
    final wifiName = await info.getWifiName();
    if (!mounted) return;
    if (wifiName == null || wifiName.isEmpty) {
      AppSettings.openAppSettings(type: AppSettingsType.wifi);
    } else {
      final selectedDevice = await showDialog(
        context: context,
        builder: (_) => const DeviceScanDialog(),
      );
      if (selectedDevice != null) {
        RcSender.setTarget(selectedDevice.ip, selectedDevice.port ?? 8888);
        setState(() {
          isUdpConnected = true;
        });
      }
    }
  }

  void _onRightJoystickChanged(double dx, double dy) {
    print('右摇杆偏移：$dx, $dy');
    RcSender.updateChannel(0, (2008 + dx * 500).clamp(1000, 2000).toInt());
    RcSender.updateChannel(1, (1500 + dy * 500).clamp(1000, 2000).toInt());
  }

  void _onLeftJoystickChanged(double dy) {
    print('左摇杆偏移：$dy');
    RcSender.updateChannel(3, (1500 + dy * 500).clamp(1000, 2000).toInt());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ControlAppBar(
        onMenu: () {},
        onWifi: () {
          _onWifiButtonPressed(context);
        },
        onSettings: () {},
        wifiIconColor: isUdpConnected ? iconStyle.color : Colors.grey,
      ),
      backgroundColor: const Color(0xFFF7F7FA),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 最左弹簧
            Expanded(child: SizedBox()),
            // 左侧摇杆区垂直居中
            Expanded(
              flex: 3,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    VerticalDraggableJoystick(
                      onChanged: (dy) { print('左摇杆偏移：$dy');},
                    ),
                    SizedBox(width: 12),
                    SpeedIndicator(
                      progress: 0,
                    ),
                  ],
                ),
              ),
            ),
            // 左弹簧
            Expanded(child: SizedBox()),
            // 居中且不拉伸的状态面板
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 210,
                  maxWidth: 320,
                ),
                child: AircraftStatusPanel(
                  status: AircraftStatus(
                    batteryVoltage: 11.1,
                    batteryCurrent: 2.3,
                    controlMode: '自动飞行',
                    totalSpeed: 5.6,
                    roll: 2.1,
                    pitch: -1.3,
                    yaw: 45.0,
                    x: 1.2,
                    y: 3.4,
                    z: 0.8,
                    flapFrequency: 12.5,
                    flapAmplitude: 0.7,
                    pValue: 0.85,
                    angleOffset: 1.2,
                  ),
                ),
              ),
            ),
            // 右弹簧
            Expanded(child: SizedBox()),
            // 右侧摇杆区垂直居中
            Expanded(
              flex: 3,
              child: Center(
                  child:Stack(
                    alignment: Alignment.center,
                    children: [
                      AngleIndicator(initialAngle: 90,),
                      DraggableJoystick(
                        onChanged: (dx, dy) { print('右摇杆偏移：$dx, $dy');},
                      ),
                    ]
                  ),
              ),
            ),
            // 最右弹簧
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}