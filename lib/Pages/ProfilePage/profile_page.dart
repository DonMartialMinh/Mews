import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mews/Authentication/authentication.dart';
import 'package:mews/Values/colors.dart';
import 'package:mews/Values/dimens.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Values/images.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:mews/Widgets/dock_button.dart';
import 'package:mews/routes.dart';

class ProfilePage extends StatelessWidget {
  String name = "Võ Minh Đôn";
  String email = "vominhdona1@gmail.com";
  BuildContext? ct;

  @override
  Widget build(BuildContext context) {
    ct = context;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: CustomText(
        'Profile',
        fontWeight: FontWeight.w700,
        fontSize: FontSize.BIG,
      ),
      leading: Container(),
      actions: [
        IconButton(
          padding: const EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: CustomText('Are you sure?'),
                content: CustomText('Do you want to sign out'),
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
                    onTap: () {
                      AuthenticationHelper().signOut();
                      Navigator.pushNamed(ct!, RoutePaths.SIGNIN);
                    },
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
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildInfor(),
          const SizedBox(height: 30),
          _buildFeature(),
        ],
      ),
    );
  }

  Widget _buildInfor() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimen.spacing_3),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 50,
            child: Image.asset(
              AppImage.imgNancy,
              width: AppDimen.avatarRadius,
              height: AppDimen.avatarRadius,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDimen.spacing_3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(name, fontSize: FontSize.BIG),
                CustomText(email,
                    fontSize: FontSize.SMALL, color: AppColor.colorTextLight)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFeature() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimen.spacing_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "News",
            fontSize: FontSize.BIG,
            color: AppColor.colorTextLight,
            fontWeight: FontWeight.bold,
          ),
          const Divider(
            color: AppColor.colorTextLight,
            height: 1,
            thickness: 1,
          ),
          component(Icons.checklist, "Favorites",
              () => {Navigator.pushNamed(ct!, RoutePaths.FAVORITE)}),
          component(Icons.check, "Followings", () => {}),
          component(Icons.timer, "Recent Reading",
              () => {Navigator.pushNamed(ct!, RoutePaths.RECENT)}),
          const SizedBox(height: 30),
          CustomText(
            "Utilities",
            fontSize: FontSize.BIG,
            color: AppColor.colorTextLight,
            fontWeight: FontWeight.bold,
          ),
          const Divider(
            color: AppColor.colorTextLight,
            height: 1,
            thickness: 1,
          ),
          component(Icons.cloud_outlined, "Weather",
              () => {Navigator.pushNamed(ct!, RoutePaths.WEATHER)}),
          component(Icons.calendar_today, "Calendar",
              () => {Navigator.pushNamed(ct!, RoutePaths.CALENDAR)}),
          component(Icons.money, "Lottery results",
              () => {Navigator.pushNamed(ct!, RoutePaths.LOTTERY)}),
        ],
      ),
    );
  }

  Widget component(IconData icons, String name, OnPressed onPressed) {
    return GestureDetector(
      child: Container(
        height: 50,
        child: Row(
          children: [
            Icon(icons),
            const SizedBox(width: 20),
            CustomText(
              name,
              fontSize: FontSize.MEDIUM,
            )
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
