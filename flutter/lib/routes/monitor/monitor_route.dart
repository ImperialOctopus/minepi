import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/monitor_bloc.dart';

/// Route for monitor page.
class MonitorRoute extends StatelessWidget {
  /// Login key.
  final String loginKey;

  /// Route for monitor page.
  const MonitorRoute({required this.loginKey});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MonitorBloc(loginKey: loginKey),
      child: Container(),
    );
  }
}
