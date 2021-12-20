import 'package:mews/Models/article.dart';

class ArticleList {
  List<Article> list = [];

  toJSON() {
    return list.map((item) {
      return item.toJson();
    }).toList();
  }
}
