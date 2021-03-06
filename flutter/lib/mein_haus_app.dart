import 'package:flutter/material.dart';

import 'routes/routes.dart';
import 'theme/theme.dart';

/// Main app widget.
class MeinHausApp extends StatelessWidget {
  /// Main app widget.
  MeinHausApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hexal Flutter',
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
  @override
  void initState() {
    super.initState();
    // Initialise blocs.
  }

  @override
  Widget build(BuildContext context) {
    // Bloc providers
    return widget.child ?? Container();
  }
}
