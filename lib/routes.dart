import 'package:flutter/material.dart';
import 'package:mews/Pages/HomePage/home_page.dart';
import 'package:mews/Pages/RecentPage/recent_page.dart';
import 'package:mews/Pages/SignInPage/sign_in_page.dart';
import 'package:mews/Pages/SignUpPage/sign_up_page.dart';
import 'package:mews/Pages/WebPage/web_page.dart';

import 'Pages/FavoritePage/favorite_page.dart';

class RoutePaths {
  static const String SIGNUP = "/SignUpPage";
  static const String SIGNIN = "/SignInPage";
  static const String HOME = "/HomePage";
  static const String WEATHER = "/Weather";
  static const String LOTTERY = "/Lottery";
  static const String CALENDAR = "/Calendar";
  static const String FAVORITE = "/FavoritePage";
  static const String RECENT = "/RecentPage";
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
      case RoutePaths.WEATHER:
        return MaterialPageRoute(
            builder: (_) => WebPage(
                  title: 'Weather',
                  url: 'https://www.windy.com/',
                ),
            settings: settings);
      case RoutePaths.LOTTERY:
        return MaterialPageRoute(
            builder: (_) => WebPage(
                  title: 'Lottery results',
                  url: 'https://www.kqxs.vn/',
                ),
            settings: settings);
      case RoutePaths.CALENDAR:
        return MaterialPageRoute(
            builder: (_) => WebPage(
                  title: 'Calendar',
                  url: 'https://www.24h.com.vn/lich-van-nien-c936.html',
                ),
            settings: settings);
      case RoutePaths.FAVORITE:
        return MaterialPageRoute(
            builder: (_) => FavoritePage(), settings: settings);
      case RoutePaths.RECENT:
        return MaterialPageRoute(
            builder: (_) => RecentPage(), settings: settings);
      default:
        return null;
    }
  }
}
