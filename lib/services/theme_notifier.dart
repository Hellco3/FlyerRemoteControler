import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 主题模式枚举
enum AppThemeMode {
  light,
  dark,
  system,
}

/// 主题管理器，负责主题模式的切换与持久化
class ThemeNotifier extends ChangeNotifier {
  static const String _themeModeKey = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.system;
  AppThemeMode _appThemeMode = AppThemeMode.system;

  ThemeNotifier() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;
  AppThemeMode get appThemeMode => _appThemeMode;

  /// 切换主题模式
  Future<void> setThemeMode(AppThemeMode mode) async {
    _appThemeMode = mode;
    switch (mode) {
      case AppThemeMode.light:
        _themeMode = ThemeMode.light;
        await _saveThemeMode('light');
        break;
      case AppThemeMode.dark:
        _themeMode = ThemeMode.dark;
        await _saveThemeMode('dark');
        break;
      case AppThemeMode.system:
        _themeMode = ThemeMode.system;
        await _removeThemeMode();
        break;
    }
    notifyListeners();
  }

  /// 加载持久化的主题模式
  Future<void> _loadThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? mode = prefs.getString(_themeModeKey);
    if (mode == 'light') {
      _themeMode = ThemeMode.light;
      _appThemeMode = AppThemeMode.light;
    } else if (mode == 'dark') {
      _themeMode = ThemeMode.dark;
      _appThemeMode = AppThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
      _appThemeMode = AppThemeMode.system;
    }
    notifyListeners();
  }

  /// 保存主题模式
  Future<void> _saveThemeMode(String mode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode);
  }

  /// 移除主题模式（跟随系统）
  Future<void> _removeThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_themeModeKey);
  }
} 