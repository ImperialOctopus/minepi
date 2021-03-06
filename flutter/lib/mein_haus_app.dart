import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/authentication/authentication_event.dart';
import 'bloc/authentication/authentication_state.dart';
import 'bloc/remember/remember_bloc.dart';
import 'bloc/remember/remember_event.dart';
import 'repository/data_repository/data_repository.dart';
import 'repository/data_repository/firebase_data_repository.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

/// Main app widget.
class MeinHausApp extends StatelessWidget {
  /// Key for navigator.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// Main app widget.
  MeinHausApp();

  @override
  Widget build(BuildContext context) {
    return _BlocProvider(
      child: MaterialApp(
        title: 'Mein Haus Monitor',
        theme: themeData,
        debugShowCheckedModeBanner: false,
        navigatorKey: MeinHausApp.navigatorKey,
        initialRoute: '/',
        routes: routes,
        builder: (context, widget) => _BlocProvider(child: widget),
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
  late final DataRepository _dataRepository;

  late final RememberBloc _rememberBloc;
  late final AuthenticationBloc _authBloc;

  @override
  void initState() {
    super.initState();
    // Initialise blocs.
    _dataRepository = FirebaseDataRepository();

    _rememberBloc = RememberBloc()..add(const RememberAppStarted());
    _authBloc = AuthenticationBloc(
        dataRepository: _dataRepository, rememberBloc: _rememberBloc)
      ..add(const AuthenticationAppStarted());
  }

  @override
  Widget build(BuildContext context) {
    // Bloc providers
    return RepositoryProvider.value(
      value: _dataRepository,
      child: BlocProvider<AuthenticationBloc>.value(
        value: _authBloc,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              MeinHausApp.navigatorKey.currentState?.pushNamed('/monitor');
            }
          },
          child: widget.child,
        ),
      ),
    );
  }
}
