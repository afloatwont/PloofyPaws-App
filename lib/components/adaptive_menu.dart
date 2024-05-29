import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptivePopupMenuItem {
  final VoidCallback? onTap;
  final String label;
  final Icon icon;
  final int value;
  final bool enabled;

  AdaptivePopupMenuItem(
      {this.enabled = true, required this.value, this.onTap, required this.label, required this.icon});
}

class AdaptivePopupMenu extends StatelessWidget {
  final Widget? child;
  final List<AdaptivePopupMenuItem> items;
  final Function(int?) onSelected;
  final bool enabled;
  const AdaptivePopupMenu({super.key, this.enabled = true, this.child, required this.items, required this.onSelected});

  Widget _buildIOS() {
    return PopupMenuButton<int>(
      enabled: enabled,
      splashRadius: 0.1,
      position: PopupMenuPosition.under,
      constraints: const BoxConstraints(minWidth: 200),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      )),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFEEEEEE),
      elevation: 5,
      onSelected: onSelected,
      itemBuilder: (context) => items
          .asMap()
          .entries
          .map(
            (e) => e.key == items.length - 1
                ? [_buildMenuItem(e.value)]
                : [
                    _buildMenuItem(e.value),
                    const PopupMenuDivider(),
                  ],
          )
          .expand<PopupMenuEntry<int>>((e) => e)
          .toList(),
      child: child,
    );
  }

  Widget _buildAndroid() {
    return PopupMenuButton<int>(
      onSelected: onSelected,
      enabled: enabled,
      itemBuilder: (context) => items.map<PopupMenuEntry<int>>((e) => _buildMenuItem(e)).toList(),
      child: child,
    );
  }

  PopupMenuEntry<int> _buildMenuItem(AdaptivePopupMenuItem item) {
    if (Platform.isIOS) {
      return PopupMenuItem(
        enabled: item.enabled,
        onTap: item.onTap,
        value: item.value,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.label),
            Icon(
              color: CupertinoColors.black,
              item.icon.icon,
              size: 18,
            ),
          ],
        ),
      );
    }

    return PopupMenuItem(
      enabled: item.enabled,
      value: item.value,
      onTap: item.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.label),
          item.icon,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Theme(
        data: ThemeData(
          dividerColor: const Color(0xFF3C3C43),
          shadowColor: const Color.fromRGBO(0, 0, 0, 0.1),
        ),
        child: _buildIOS(),
      );
    }
    return _buildAndroid();
  }
}
