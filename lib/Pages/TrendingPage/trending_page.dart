import 'package:flutter/material.dart';
import 'package:mews/Models/article.dart';
import 'package:mews/Services/api_services.dart';
import 'package:mews/Values/colors.dart';
import 'package:mews/Values/dimens.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:mews/Widgets/trending_listtile.dart';
import 'package:mews/constants.dart';

class TrendingPage extends StatefulWidget {
  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
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
          'Trending',
          fontWeight: FontWeight.w700,
          fontSize: FontSize.BIG,
        ));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimen.horizontalSpacing),
            child: CustomText(
              "HighLight",
              fontSize: FontSize.BIG,
              color: AppColor.colorTextLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
            child: Divider(
              color: AppColor.colorTextLight,
              height: 1,
              thickness: 1,
            ),
          ),
          SizedBox(height: 340, child: _buildArticle(NewsCategory.trending)),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimen.horizontalSpacing),
            child: CustomText(
              "People also read",
              fontSize: FontSize.BIG,
              color: AppColor.colorTextLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
            child: Divider(
              color: AppColor.colorTextLight,
              height: 1,
              thickness: 1,
            ),
          ),
          SizedBox(
              height: 340, child: _buildArticle(NewsCategory.peoplemayread)),
        ],
      ),
    );
  }

  Widget _buildArticle(NewsCategory category) {
    return FutureBuilder(
        future: client.getArticle(category),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  trendingListTile(articles[index], context),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
