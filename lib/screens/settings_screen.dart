import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flyer_controler/utilities/constants.dart';
import 'package:flyer_controler/services/theme_notifier.dart';

/// 设置页面
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppThemeMode _selectedMode;
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _udpPortController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    _selectedMode = themeNotifier.appThemeMode;
    // 可根据需要初始化IP和端口
    _ipController.text = '';
    _udpPortController.text = '';
  }

  @override
  void dispose() {
    _ipController.dispose();
    _udpPortController.dispose();
    super.dispose();
  }

  void _onApplyPressed() {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    themeNotifier.setThemeMode(_selectedMode);
    final String ip = _ipController.text.trim();
    final String udpPort = _udpPortController.text.trim();
    debugPrint('保存IP: $ip, UDP端口: $udpPort');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('所有设置已应用')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置', style: Theme.of(context).appBarTheme.titleTextStyle),
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _onApplyPressed,
            child: const Text('应用'),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '主题模式',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Radio<AppThemeMode>(
                            value: AppThemeMode.light,
                            groupValue: _selectedMode,
                            onChanged: (mode) {
                              if (mode != null) {
                                setState(() {
                                  _selectedMode = mode;
                                });
                              }
                            },
                          ),
                          const Text('浅色模式'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Radio<AppThemeMode>(
                            value: AppThemeMode.dark,
                            groupValue: _selectedMode,
                            onChanged: (mode) {
                              if (mode != null) {
                                setState(() {
                                  _selectedMode = mode;
                                });
                              }
                            },
                          ),
                          const Text('深色模式'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Radio<AppThemeMode>(
                            value: AppThemeMode.system,
                            groupValue: _selectedMode,
                            onChanged: (mode) {
                              if (mode != null) {
                                setState(() {
                                  _selectedMode = mode;
                                });
                              }
                            },
                          ),
                          const Text('跟随系统'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '网络设置',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: _ipController,
                        decoration: const InputDecoration(
                          labelText: 'IP地址',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: _udpPortController,
                        decoration: const InputDecoration(
                          labelText: 'UDP端口',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 