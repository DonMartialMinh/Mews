import 'package:flutter/material.dart';
import 'package:mews/Pages/SignInPage/sign_in_page.dart';

class RoutePaths {
  static const String SIGNUP = "/SignUpPage";
  static const String SIGNIN = "/SignInPage";
}

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RoutePaths.SIGNUP:
      //   return MaterialPageRoute(
      //       builder: (_) => SignUpPage(), settings: settings);
      case RoutePaths.SIGNIN:
        return MaterialPageRoute(
            builder: (_) => SignInPage(), settings: settings);
      default:
        return null;
    }
  }
}
