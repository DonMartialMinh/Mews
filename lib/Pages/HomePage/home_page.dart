import 'package:flutter/material.dart';
import 'package:mews/Pages/NewsPage/news_page.dart';
import 'package:mews/Pages/NotificationPage/notification_page.dart';
import 'package:mews/Pages/ProfilePage/profile_page.dart';
import 'package:mews/Pages/TrendingPage/trending_page.dart';
import 'package:mews/Values/colors.dart';
import 'package:mews/Widgets/bottom_navigation_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _tabs = [
    NewsPage(),
    TrendingPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: _tabs,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.colorDropShadow.withOpacity(0.20),
                spreadRadius: 0.0,
                blurRadius: 50.0,
                offset: Offset(0.0, -2.0), // changes position of shadow
              ),
            ],
          ),
          child: BottomNavigationView(listener: _clickTab),
        ),
      ),
    );
  }

  void _clickTab(int index, bool isDoubleTab) {
    // final _isLoggedIn = false;
    // if (!_isLoggedIn && index == 4) {
    //   Navigator.of(context).pushNamed(RoutePaths.LOGIN_PAGE);
    // } else {
    _tabController.animateTo(index);
    // }
  }
}
