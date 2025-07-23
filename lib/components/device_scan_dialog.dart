import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:network_info_plus/network_info_plus.dart';

/// 发现的设备数据类型
class DiscoveredDevice {
  final String ip;
  final String? name;
  final int? port;
  const DiscoveredDevice({required this.ip, this.name, this.port});
}

/// 局域网设备扫描对话框
class DeviceScanDialog extends StatefulWidget {
  const DeviceScanDialog({super.key});

  @override
  State<DeviceScanDialog> createState() => _DeviceScanDialogState();
}

class _DeviceScanDialogState extends State<DeviceScanDialog> {
  bool isLoading = false;
  String? error;
  final List<DiscoveredDevice> _devices = [];

  @override
  void initState() {
    super.initState();
    _scanDevices();
  }

  /// 扫描局域网内 esp32 设备（主动IP扫描+HTTP特征识别，后台isolate执行）
  Future<void> _scanDevices() async {
    setState(() {
      isLoading = true;
      error = null;
      _devices.clear();
    });
    try {
      final info = NetworkInfo();
      final ip = await info.getWifiIP();
      if (ip == null) {
        setState(() {
          error = '无法获取本机IP，未连接WiFi？';
          isLoading = false;
        });
        return;
      }
      final subnet = ip.substring(0, ip.lastIndexOf('.') + 1); // 例如192.168.0.
      // 在后台isolate中执行扫描任务
      final List<DiscoveredDevice> found = await compute(_scanSubnet, subnet);
      setState(() {
        _devices.addAll(found);
        isLoading = false;
      });
    } catch (e, stack) {
      setState(() {
        error = '扫描失败: $e\n$stack';
        isLoading = false;
      });
    }
  }

  /// UI构建
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('局域网设备扫描'),
      content: SizedBox(
        width: 320,
        height: 360,
        child: _buildDeviceList(),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : _scanDevices,
          child: const Text('刷新'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('关闭'),
        ),
      ],
    );
  }

  Widget _buildDeviceList() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (error != null) {
      return Center(child: Text(error!, style: const TextStyle(color: Colors.red)));
    } else if (_devices.isEmpty) {
      return const Center(child: Text('未发现设备'));
    } else {
      return ListView.separated(
        itemCount: _devices.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final device = _devices[index];
          return ListTile(
            leading: const Icon(Icons.devices),
            title: Text(device.name ?? 'esp32'),
            subtitle: Text('${device.ip}${device.port != null ? ':${device.port}' : ''}'),
            onTap: () {
              Navigator.of(context).pop(device);
            },
          );
        },
      );
    }
  }
}

/// 后台isolate中执行的扫描函数
Future<List<DiscoveredDevice>> _scanSubnet(String subnet) async {
  const int port = 80; // esp32 http端口
  const int timeoutMs = 300;
  final List<DiscoveredDevice> found = [];
  final List<Future> futures = [];
  for (int i = 1; i < 255; i++) {
    final ip = '$subnet$i';
    futures.add(_checkEsp32(ip, port, timeoutMs).then((result) {
      if (result != null) found.add(result);
    }));
  }
  await Future.wait(futures);
  return found;
}

/// 检查单个IP是否为esp32设备（通过HTTP特征识别）
Future<DiscoveredDevice?> _checkEsp32(String ip, int port, int timeoutMs) async {
  try {
    final httpClient = HttpClient();
    httpClient.connectionTimeout = Duration(milliseconds: timeoutMs);
    final request = await httpClient.getUrl(Uri.parse('http://$ip:$port/'));
    final response = await request.close();
    final content = await response.transform(SystemEncoding().decoder).join();
    httpClient.close();
    // 识别并提取 device-id 的 content
    final RegExp metaExpId = RegExp(
      "<meta name=['\"]device-id['\"] content=['\"](.*?)['\"]>",
      caseSensitive: false
    );
    final RegExp metaExpPort = RegExp(
      "<meta name=['\"]rc-udp-port['\"] content=['\"](.*?)['\"]>",
      caseSensitive: false
    );
    final Match? matchId = metaExpId.firstMatch(content);
    final Match? matchPort = metaExpPort.firstMatch(content);
    if (matchId != null && matchPort != null) {
      final String deviceName = matchId.group(1) ?? 'unknown';
      final String devicePort = matchPort.group(1) ?? '0';
      // 确保设备名包含 'Neuro'
      if (deviceName.toLowerCase().contains('neuro')) {
        return DiscoveredDevice(ip: ip, name: deviceName, port: int.parse(devicePort));
      }
    }
  } catch (_) {}
  return null;
} 