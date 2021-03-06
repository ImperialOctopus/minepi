import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Route for menu page.
class MenuRoute extends StatefulWidget {
  /// Route for menu page.
  const MenuRoute();

  @override
  _MenuRouteState createState() => _MenuRouteState();
}

class _MenuRouteState extends State<MenuRoute> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Menu'),
        TextField(
          controller: _textController,
        ),
        ElevatedButton(
          onPressed: () => BlocProvider.of<KeyBloc>(context)
              .add(KeySubmitted(loginKey: _textController.text)),
          child: const Text('Submit'),
        )
      ],
    );
  }
}
