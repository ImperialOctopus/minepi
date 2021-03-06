import 'package:flutter/material.dart';

/// Item for the monitor list.
class MonitorListItem extends StatelessWidget {
  /// Color name to show.
  final String color;

  /// Value of this item.
  final int value;

  /// Item for the monitor list.
  const MonitorListItem({required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('/assets/dyes/' + color + '_dye.png'),
      title: Text(color),
      trailing: Text(value == 0 ? '' : value.toString()),
    );
  }
}
