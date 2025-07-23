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
    return Stack(
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
                  icon: Icon(Icons.menu),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onWifi,
                  icon: Icon(Icons.wifi, color: wifiIconColor),
                ),
                IconButton(
                  onPressed: onSettings,
                  icon: const Icon(Icons.settings),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
        const Text(
          'Wing Control',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
} 