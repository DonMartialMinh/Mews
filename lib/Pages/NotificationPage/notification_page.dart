import 'package:flutter/material.dart';
import 'package:mews/Values/dimens.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_text.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
        leading: Container(),
        title: CustomText(
          'Notifications',
          fontWeight: FontWeight.w700,
          fontSize: FontSize.BIG,
        ));
  }

  Widget _buildBody() {
    return Container(child: ListView(children: notifications));
  }
}

class Notification extends StatelessWidget {
  String? title;
  String? description;
  String? urlImage;
  Notification({Key? key, this.title, this.description, this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 20,
      leading: SizedBox(
        height: 100,
        width: 100,
        child: Image.network(urlImage!),
      ),
      title: CustomText(
        title!,
        fontSize: FontSize.MEDIUM,
      ),
    );
  }
}

List<Notification> notifications = [
  Notification(
    title: "Bà Nguyễn Phương Hằng bị kiện",
    description:
        "Bà Nguyễn Phương Hằng bị kiện Bà Nguyễn Phương Hằng bị kiện Bà Nguyễn Phương Hằng bị kiện",
    urlImage:
        "https://nld.mediacdn.vn/291774122806476800/2021/10/18/a20-16345552119152022175571.jpeg",
  ),
  Notification(
    title: "Bà Nguyễn Phương Hằng bị kiện",
    description:
        "Bà Nguyễn Phương Hằng bị kiện Bà Nguyễn Phương Hằng bị kiện Bà Nguyễn Phương Hằng bị kiện",
    urlImage:
        "https://nld.mediacdn.vn/291774122806476800/2021/10/18/a20-16345552119152022175571.jpeg",
  ),
  Notification(
    title: "Bà Nguyễn Phương Hằng bị kiện",
    description:
        "Bà Nguyễn Phương Hằng bị kiện Bà Nguyễn Phương Hằng bị kiện Bà Nguyễn Phương Hằng bị kiện",
    urlImage:
        "https://nld.mediacdn.vn/291774122806476800/2021/10/18/a20-16345552119152022175571.jpeg",
  ),
  Notification(
    title: "Bà Nguyễn Phương Hằng bị kiện",
    description:
        "Bà Nguyễn Phương Hằng bị kiện Bà Nguyễn Phương Hằng bị kiện Bà Nguyễn Phương Hằng bị kiện",
    urlImage:
        "https://nld.mediacdn.vn/291774122806476800/2021/10/18/a20-16345552119152022175571.jpeg",
  ),
];
