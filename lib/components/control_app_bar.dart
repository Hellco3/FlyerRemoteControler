import 'package:flutter/material.dart';
import 'package:flyer_controler/utilities/constants.dart';

class ControlAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenu;
  final VoidCallback? onWifi;
  final VoidCallback? onSettings;
  final Color wifiIconColor;

  const ControlAppBar({
    super.key,
    this.onMenu,
    this.onWifi,
    this.onSettings,
    this.wifiIconColor = Colors.black,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;

    return Container(
      color: appBarTheme.backgroundColor, // 背景色
      child: IconTheme(
        data: appBarTheme.iconTheme ?? const IconThemeData(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: onMenu,
                      icon: Icon(Icons.menu), // 自动用主题色
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: onWifi,
                      icon: Icon(Icons.wifi, color: wifiIconColor), // 单独指定颜色
                    ),
                    IconButton(
                      onPressed: onSettings,
                      icon: Icon(Icons.settings), // 自动用主题色
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ],
            ),
            Text(
              'Wing Control',
              style: appBarTheme.titleTextStyle, // 标题字体和颜色
            ),
          ],
        ),
      ),
    );
  }
} 