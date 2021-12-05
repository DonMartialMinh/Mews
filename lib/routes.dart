import 'package:flutter/material.dart';
import 'package:mews/Pages/HomePage/home_page.dart';
import 'package:mews/Pages/SignInPage/sign_in_page.dart';
import 'package:mews/Pages/SignUpPage/sign_up_page.dart';

class RoutePaths {
  static const String SIGNUP = "/SignUpPage";
  static const String SIGNIN = "/SignInPage";
  static const String HOME = "/HomePage";
}

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.SIGNUP:
        return MaterialPageRoute(
            builder: (_) => SignUpPage(), settings: settings);
      case RoutePaths.SIGNIN:
        return MaterialPageRoute(
            builder: (_) => SignInPage(), settings: settings);
      case RoutePaths.HOME:
        return MaterialPageRoute(
            builder: (_) => HomePage(), settings: settings);
      default:
        return null;
    }
  }
}
