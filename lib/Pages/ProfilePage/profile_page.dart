import 'package:flutter/material.dart';
import 'package:mews/Values/colors.dart';
import 'package:mews/Values/dimens.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Values/images.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:mews/Widgets/dock_button.dart';

class ProfilePage extends StatelessWidget {
  String name = "Võ Minh Đôn";
  String email = "vominhdona1@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText(
        'Profile',
        fontSize: FontSize.BIG,
      ),
      leading: Container(),
      actions: [
        IconButton(
          padding: const EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
          onPressed: () {},
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
                    fontSize: FontSize.MEDIUM, color: AppColor.colorTextLight)
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
            "Tin tức",
            fontSize: FontSize.BIG,
            color: AppColor.colorTextLight,
            fontWeight: FontWeight.bold,
          ),
          const Divider(
            color: AppColor.colorTextLight,
            height: 1,
            thickness: 1,
          ),
          component(Icons.checklist, "Tin yêu thích", () => {}),
          component(Icons.check, "Đang theo dõi", () => {}),
          component(Icons.timer, "Đọc gần đây", () => {}),
          const SizedBox(height: 30),
          CustomText(
            "Tiện ích",
            fontSize: FontSize.BIG,
            color: AppColor.colorTextLight,
            fontWeight: FontWeight.bold,
          ),
          const Divider(
            color: AppColor.colorTextLight,
            height: 1,
            thickness: 1,
          ),
          component(Icons.cloud_outlined, "Thời tiết", () => {}),
          component(Icons.calendar_today, "Lịch việt", () => {}),
          component(Icons.money, "Kết quả sổ xố", () => {}),
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
