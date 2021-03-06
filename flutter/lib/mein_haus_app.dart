import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes/bloc/key/key_bloc.dart';
import 'routes/bloc/key/key_event.dart';
import 'routes/bloc/key/key_state.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

/// Main app widget.
class MeinHausApp extends StatelessWidget {
  /// Main app widget.
  MeinHausApp();

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return _BlocProvider(
      child: MaterialApp(
        title: 'Mein Haus Monitor',
        theme: themeData,
        //debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        builder: (context, widget) {
          return BlocListener<KeyBloc, KeyState>(
            listener: (context, state) {
              if (state is KeyUnloaded) {
              } else if (state is KeyLoaded) {
          _navigator.pushNamedAndRemoveUntil(newRouteName, (route) => false)
              } else {
                throw FallThroughError();
              }
            },
            child: widget,
          );
        },
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}

class _BlocProvider extends StatefulWidget {
  final Widget? child;

  const _BlocProvider({required this.child});

  @override
  _BlocProviderState createState() => _BlocProviderState();
}

class _BlocProviderState extends State<_BlocProvider> {
  late final KeyBloc _keyBloc;

  @override
  void initState() {
    super.initState();
    // Initialise blocs.
    _keyBloc = KeyBloc()..add(KeyAppStarted());
  }

  @override
  Widget build(BuildContext context) {
    // Bloc providers
    return BlocProvider<KeyBloc>.value(
      value: _keyBloc,
      child: widget.child ?? Container(),
    );
  }
}
