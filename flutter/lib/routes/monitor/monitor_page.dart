import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/output_state.dart';
import 'bloc/monitor_cubit.dart';
import 'component/monitor_list_item.dart';

/// Page for monitor.
class MonitorPage extends StatelessWidget {
  /// Page for monitor.
  const MonitorPage();

  /// Minecraft wool colours.
  static const List<String> colours = [
    'white',
    'orange',
    'magenta',
    'light_blue',
    'yellow',
    'lime',
    'pink',
    'grey',
    'light_grey',
    'cyan',
    'purple',
    'blue',
    'brown',
    'green',
    'red',
    'black',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MonitorCubit, OutputState?>(
        builder: (context, state) {
          if (state == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: colours
                  .map((color) => MonitorListItem(
                      color: color, value: state.data[color] ?? 0))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
