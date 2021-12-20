import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mews/Pages/NewsPage/news_page.dart';
import 'package:mews/Pages/NotificationPage/notification_page.dart';
import 'package:mews/Pages/ProfilePage/profile_page.dart';
import 'package:mews/Pages/TrendingPage/trending_page.dart';
import 'package:mews/Values/colors.dart';
import 'package:mews/Widgets/bottom_navigation_view.dart';
import 'package:mews/Widgets/custom_text.dart';

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
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: CustomText('Are you sure?'),
            content: CustomText('Do you want to exit an App'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: CustomText(
                  "NO",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => exit(0),
                child: CustomText(
                  "YES",
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
        return true;
      },
      child: Container(
        color: Colors.white,
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _tabs,
          ),
          bottomNavigationBar: Container(
            //padding: const EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.colorDropShadow.withOpacity(0.20),
                  spreadRadius: 0.0,
                  blurRadius: 50.0,
                  offset: const Offset(0.0, -2.0), // changes position of shadow
                ),
              ],
            ),
            child: BottomNavigationView(
              listener: _clickTab,
            ),
          ),
        ),
      ),
    );
  }

  void _clickTab(int index, bool isDoubleTab) {
    _tabController.animateTo(index);
  }
}
