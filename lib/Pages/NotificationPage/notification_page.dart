import 'package:flutter/material.dart';
import 'package:mews/Models/article.dart';
import 'package:mews/Pages/ArticlePage/article_page.dart';
import 'package:mews/Services/api_services.dart';
import 'package:mews/Values/colors.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Values/images.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:mews/constants.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  ApiService client = ApiService();
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
    return FutureBuilder(
        future: client.getArticle(NewsCategory.notification),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  notificationListtile(articles[index], context),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

@override
Widget notificationListtile(Article article, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticlePage(
                    article: article,
                  )));
    },
    child: Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: ClipRRect(
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: AppImage.gifLoading,
                image: article.imageurl ?? AppImage.imgDummyUrl,
                imageErrorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    AppImage.imgDummy,
                    fit: BoxFit.cover,
                  );
                },
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(getInterval(article.time!),
                  color: AppColor.colorTextLight, fontSize: FontSize.SMALL),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                child: CustomText(
                  article.title!,
                  fontSize: FontSize.MEDIUM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ))
        ],
      ),
    ),
  );
}

String getInterval(String time) {
  List<String> dateElement = time.substring(0, 10).split('/');
  List<String> timeElement =
      time.substring(time.length - 5, time.length).split(':');
  final date = DateTime(
      int.parse(dateElement[2]),
      int.parse(dateElement[1]),
      int.parse(dateElement[0]),
      int.parse(timeElement[0]),
      int.parse(timeElement[1]));
  final currentDate = DateTime.now();
  final dayDifference = currentDate.difference(date).inDays;
  if (dayDifference != 0) {
    return "$dayDifference ngày trước";
  }
  final hourDifference = currentDate.difference(date).inHours;
  if (hourDifference != 0) {
    return "$hourDifference giờ trước";
  }
  final minuteDifference = currentDate.difference(date).inMinutes;
  if (minuteDifference != 0) {
    return "$minuteDifference phút trước";
  }
  return "vừa xong";
}
