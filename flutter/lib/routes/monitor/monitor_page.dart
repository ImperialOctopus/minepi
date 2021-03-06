import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/output_state.dart';
import 'bloc/monitor_cubit.dart';

/// Page for monitor.
class MonitorPage extends StatelessWidget {
  /// Page for monitor.
  const MonitorPage();

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
            return Center(child: Text(state.toString()));
          }
        },
      ),
    );
  }
}
