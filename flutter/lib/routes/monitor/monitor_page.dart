import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/output_state.dart';
import 'bloc/monitor_cubit.dart';
import 'component/monitor_list_item.dart';
import '../../extensions/map_to_iterable.dart';

/// Filter to apply to monitor page.
enum FilterType {
  /// Default.
  minecraft,

  /// Hide zeroes.
  onlyNonZero,

  /// Alphabetical by name.
  alphabetical,

  /// Descending by number.
  numerical,
}

/// Page for monitor.
class MonitorPage extends StatefulWidget {
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
    'gray',
    'light_gray',
    'cyan',
    'purple',
    'blue',
    'brown',
    'green',
    'red',
    'black',
  ];

  @override
  _MonitorPageState createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  late FilterType _filter;

  @override
  void initState() {
    super.initState();
    _filter = FilterType.minecraft;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MinePi Monitor'),
        actions: [
          PopupMenuButton<FilterType>(
            onSelected: (FilterType result) {
              setState(() {
                _filter = result;
                print(_filter);
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterType>>[
              const PopupMenuItem<FilterType>(
                value: FilterType.minecraft,
                child: Text('Default'),
              ),
              const PopupMenuItem<FilterType>(
                value: FilterType.onlyNonZero,
                child: Text('Hide Zeroes'),
              ),
              const PopupMenuItem<FilterType>(
                value: FilterType.alphabetical,
                child: Text('Alphabetical'),
              ),
              const PopupMenuItem<FilterType>(
                value: FilterType.numerical,
                child: Text('Descending Power'),
              ),
            ],
            child: const Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MonitorCubit, OutputState?>(
          builder: (context, state) {
            if (state == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: <String, int>{
                  for (final colour in _sortedList(state.data))
                    colour: state.data[colour] ?? 0
                }
                    .mapToIterable((color, value) =>
                        MonitorListItem(color: color, value: value))
                    .toList(),
              );
            }
          },
        ),
      ),
    );
  }

  Iterable<String> _sortedList(Map<String, int> data) {
    switch (_filter) {
      case FilterType.minecraft:
        return MonitorPage.colours.toList();
      case FilterType.onlyNonZero:
        return MonitorPage.colours
            .toList()
            .where((element) => (data[element] ?? 0) != 0);
      case FilterType.alphabetical:
        return MonitorPage.colours.toList()..sort();
      case FilterType.numerical:
        return MonitorPage.colours.toList()
          ..sort((a, b) => (data[b] ?? 0).compareTo((data[a] ?? 0)));
    }
  }
}
