import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes/bloc/key/key_bloc.dart';
import 'routes/bloc/key/key_event.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

/// Main app widget.
class MeinHausApp extends StatelessWidget {
  /// Main app widget.
  MeinHausApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mein Haus Monitor',
      theme: themeData,
      //debugShowCheckedModeBanner: false,
      builder: (context, widget) => _BlocProvider(child: widget),
      initialRoute: '/',
      routes: routes,
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
