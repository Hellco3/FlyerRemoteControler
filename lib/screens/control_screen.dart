import 'package:flutter/material.dart';
import 'package:flyer_controler/components/device_scan_dialog.dart';
import 'package:flyer_controler/components/draggable_joystick.dart';
import 'package:flyer_controler/components/vertical_draggable_joystick.dart';
import 'package:flyer_controler/components/angle_indicator.dart';
import 'package:flyer_controler/components/speed_indicator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flyer_controler/components/aircraft_status_panel.dart';
import 'package:flyer_controler/components/control_app_bar.dart';
import 'package:flyer_controler/utilities/rc_sender.dart';
import 'package:flyer_controler/utilities/constants.dart';
import 'package:flyer_controler/screens/settings_screen.dart';

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
  double speedRadio = 0;
  AircraftStatus aircraftStatus = AircraftStatus();

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
        print('连接到设备：${selectedDevice.ip}:${selectedDevice.port}');
        setState(() {
          isUdpConnected = true;
        });
      }
    }
  }
  
  void _onSettingsButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  void _onLeftJoystickChanged(double dy) {
    print('左摇杆偏移：$dy');
    // 通道3：左手油门，范围 990~2011，中值1500
    final int ch3 = (900 + dy * (2011 - 900)).clamp(900, 2011).toInt();
    RcSender.updateChannel(2, ch3);
    setState(() {
      speedRadio = dy;
    });
  }

  void _onRightJoystickChanged(double dx, double dy) {
    print('右摇杆偏移：$dx, $dy');
    // 通道1：右手左右，范围 992~2011，中值1500
    final int ch1 = (1500 + dx * (2011 - 1500)).clamp(992, 2011).toInt();
    // 通道2：右手上下，范围 994~2011，中值1500
    final int ch2 = (1500 + dy * (2011 - 1500)).clamp(994, 2011).toInt();
    RcSender.setChannel(0, ch1);
    RcSender.setChannel(1, ch2);
    RcSender.send();
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: ControlAppBar(
        onMenu: () {},
        onWifi: () {
          _onWifiButtonPressed(context);
        },
        onSettings: () {
          _onSettingsButtonPressed(context);
        },
        wifiIconColor: isUdpConnected ? theme.colorScheme.primary : theme.disabledColor,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
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
                      onChanged: _onLeftJoystickChanged,
                      baseColor: theme.colorScheme.surface,
                      stickColor: theme.colorScheme.primary,
                    ),
                    SizedBox(width: 12),
                    SpeedIndicator(
                      progress: speedRadio,
                      filledColor: theme.colorScheme.primary,
                      unfilledColor: theme.disabledColor,
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
                  status: aircraftStatus,
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
                        onChanged: _onRightJoystickChanged,
                        baseColor: theme.colorScheme.surface,
                        stickColor: theme.colorScheme.primary,
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