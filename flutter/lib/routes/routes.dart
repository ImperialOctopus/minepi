import 'package:flutter/material.dart';

import 'menu/menu_route.dart';
import 'monitor/monitor_route.dart';

/// Main application routes.
final routes = <String, WidgetBuilder>{
  '/': (context) => const MenuRoute(),
  '/monitor': (context) => const MonitorRoute(),
};
