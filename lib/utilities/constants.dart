import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    icon: Icon(
      Icons.location_city,
      color: Colors.white,
    ),
    hintText: '输入城市名',
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide.none,
    )
);

class AppColors {
  static const Color primary = Color(0xFF4F8CFF);

  // 浅色主题
  static const Color lightSurface = Color(0xFFF5F5F9); // 更柔和的米白背景（原#FFF7F7FA调暗）
  static const Color lightBackground = Color(0xFFF5F5F9); // 更柔和的米白背景（原#FFF7F7FA调暗）
  static const Color lightAppBarTitle = Color(0xFF1A1A1A); // AppBar标题色（深灰替代纯黑，降低刺眼感）
  static const Color lightAppBarIcon = Color(0xFF616161); // AppBar图标色（与标题色协调的深灰）
  static const Color lightText = Color(0xFF1A1A1A); // 正文文本色（深灰提升长时间阅读舒适度）
  static const Color lightSelect = Color(0xFF2D2D2D); // 选中色（深灰替代纯黑，保留高对比度）
  static const Color lightIcon = Color(0xFF616161); // 主要图标色（与AppBar图标统一）
  static const Color lightIconButton = Color(0xFF2D2D2D); // 图标按钮色（与选中色呼应，增强交互感）
  static const Color lightButtonBackground = Color(0xFFD0D0D0); // 按钮背景色（浅灰提升点击区域识别度）
  static const Color lightIconActive = Color(0xFF1976D2); // 激活图标色（更沉稳的蓝，替代亮蓝）
  static const Color lightIconInactive = Color(0xFF9E9E9E); // 未激活图标色（中灰强化与激活态对比）
  static const Color lightShadow = Colors.black12; // 阴影色

  // 深色主题
  static const Color darkSurface = Color.fromARGB(255, 45, 45, 45); // 更柔和的深色背景
  static const Color darkBackground = Color(0xFF121212); // 更柔和的深色背景
  static const Color darkAppBarTitle = Color(0xFFFFFFFF); // AppBar标题色
  static const Color darkAppBarIcon = Color(0xFFE0E0E0); // AppBar图标色（略微柔和）
  static const Color darkText = Color(0xFFFFFFFF); // 正文文本色
  static const Color darkSelect = Color(0xFFBB86FC); // 选中色（紫色强调）
  static const Color darkIcon = Color(0xFFE0E0E0); // 主要图标色
  static const Color darkIconButton = Color(0xFFBDBDBD); // 图标按钮色（略微暗些）
  static const Color darkButtonBackground = Color(0xFF2D2D2D); // 按钮背景色
  static const Color darkIconActive = Color(0xFF64B5F6); // 激活图标色（更柔和的蓝色）
  static const Color darkIconInactive = Color(0xFF6E6E6E); // 未激活图标色（暗灰色）
}

const double kBodyLargeFontSize = 16.0;
const double kBodyMediumFontSize = 14.0;
const double kBodySmallFontSize = 12.0;