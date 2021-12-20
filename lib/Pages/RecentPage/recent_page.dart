import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mews/Models/article.dart';
import 'package:mews/Models/article_list.dart';
import 'package:mews/Services/api_services.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Widgets/app_bar.dart';
import 'package:mews/Widgets/custom_listtile.dart';
import 'package:mews/Widgets/custom_text.dart';

class RecentPage extends StatefulWidget {
  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  final recents = ArticleList();
  final local = LocalStorage('news');
  bool isLoading = true;
  bool initialized = false;
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
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: CustomText(
        'Recents',
        fontWeight: FontWeight.w700,
        fontSize: FontSize.BIG,
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: local.ready,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!initialized) {
            var items = local.getItem('recents');
            if (items != null) {
              recents.list = List<Article>.from(
                (items as List).map(
                  (item) => Article.fromJsonDynamic(item),
                ),
              );
            }
            initialized = true;
          }
          return ListView.builder(
            itemCount: recents.list.length,
            itemBuilder: (context, index) =>
                customListTile(recents.list[index], context),
          );
        });
  }
}
