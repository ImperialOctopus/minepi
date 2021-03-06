import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/authentication/authentication_state.dart';
import '../../repository/data_repository/data_repository.dart';
import 'bloc/monitor_cubit.dart';
import 'monitor_page.dart';

/// Route for monitor page.
class MonitorRoute extends StatelessWidget {
  /// Route for monitor page.
  const MonitorRoute();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is! AuthenticationAuthenticated) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return BlocProvider(
            create: (context) => MonitorCubit(
                dataRepository: RepositoryProvider.of<DataRepository>(context),
                identifier: state.identifier),
            child: const MonitorPage(),
          );
        }
      },
    );
  }
}
