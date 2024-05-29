import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, bool Function(Route<dynamic>) predicate) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, predicate);
  }

  Future<T?> push<T>(Widget widget) {
    return navigatorKey.currentState!.push<T>(MaterialPageRoute(builder: (context) => widget));
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
