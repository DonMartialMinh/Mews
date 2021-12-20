import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mews/Models/article.dart';
import 'package:mews/Services/api_services.dart';
import 'package:mews/Widgets/custom_listtile.dart';
import 'package:mews/constants.dart';

class CategoryNewsPage extends StatefulWidget {
  NewsCategory category;
  CategoryNewsPage({Key? key, required this.category}) : super(key: key);
  @override
  State<CategoryNewsPage> createState() => _CategoryNewsPageState();
}

class _CategoryNewsPageState extends State<CategoryNewsPage> {
  ApiService client = ApiService();
  late Future<List<Article>> articles;

  @override
  void initState() {
    super.initState();
    articles = client.getArticle(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: articles,
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        //let's check if we got a response or not
        if (snapshot.hasData) {
          //Now let's make a list of articles
          //List<Article> articles = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              List<Article> freshArticles =
                  await client.getArticle(widget.category);
              freshArticles.shuffle();
              setState(() {
                articles = Future.value(freshArticles);
              });
            },
            child: ListView.builder(
              //Now let's create our custom List tile
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                  customListTile(snapshot.data![index], context),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
