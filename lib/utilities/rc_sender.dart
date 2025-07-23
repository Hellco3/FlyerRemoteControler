import 'dart:typed_data';
import 'package:udp/udp.dart';
import 'dart:io';

class RcSender {
  static String remoteIp = '192.168.4.1'; // TODO: 替换为实际目标IP
  static int remotePort = 8888; // TODO: 替换为实际目标端口
  static UDP? _udp;
  static List<int> _channels = List.filled(9, 1024); // 默认中值

  /// 初始化UDP
  static Future<void> init() async {
    _udp ??= await UDP.bind(Endpoint.any());
  }

  /// 设置目标IP和端口
  static void setTarget(String ip, int port) {
    remoteIp = ip;
    remotePort = port;
  }

  /// 更新通道数据并发送
  static Future<void> sendChannels(List<int> channels) async {
    await init();
    _channels = List.from(channels);
    final packet = Uint8List(20);
    final byteData = ByteData.sublistView(packet);
    for (int i = 0; i < 9; i++) {
      byteData.setUint16(i * 2, _channels[i], Endian.little);
    }
    int crc = crc16Modbus(packet.sublist(0, 18));
    byteData.setUint16(18, crc, Endian.little);
    await _udp?.send(
      packet,
      Endpoint.unicast(InternetAddress(remoteIp), port: Port(remotePort)),
    );
  }

  /// 只更新某个通道并发送
  static Future<void> updateChannel(int index, int value) async {
    _channels[index] = value;
    await sendChannels(_channels);
  }

  /// CRC16-MODBUS算法
  static int crc16Modbus(Uint8List data, [int length = -1]) {
    int crc = 0xFFFF;
    length = length == -1 ? data.length : length;
    for (int i = 0; i < length; i++) {
      crc ^= data[i];
      for (int j = 0; j < 8; j++) {
        if ((crc & 0x0001) != 0) {
          crc = (crc >> 1) ^ 0xA001;
        } else {
          crc = crc >> 1;
        }
      }
    }
    return crc & 0xFFFF;
  }
}
 