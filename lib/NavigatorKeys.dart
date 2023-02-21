import 'package:flutter/material.dart';

class NavigatorKeys {
  static final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey();
  static final GlobalKey<NavigatorState> catalogNavigatorKey = GlobalKey();

  static int mainNavigationId = 0;
  static int catalogNavigationId = 1;
}
