import 'dart:convert';
import 'package:http/http.dart';
import 'package:mews/Models/article.dart';
import 'package:mews/constants.dart';

class ApiService {
  //let's add an Endpoint URL, you can check the website documentation
  // and learn about the different Endpoint
  //for this example I'm going to use a single endpoint

  //NOTE: make sure to use your OWN apikey, you can make a free acount and
  // choose a developer option it's FREE
  String endPointUrl =
      "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=99b6696f068d4885b25395817abff209";

  //Now let's create the http request function
  // but first let's import the http package

  Future<List<Article>> getArticle(NewsCategory category,
      {int count = 0}) async {
    if (category == NewsCategory.all) {
      endPointUrl =
          "https://ancient-gorge-54139.herokuapp.com/api/get/all/$count";
    } else {
      endPointUrl =
          "https://ancient-gorge-54139.herokuapp.com/api/get/$count/filter?category=${category.toString().split('.').last}";
    }

    Response res = await get(Uri.parse(endPointUrl));

    //first of all let's check that we got a 200 statu code: this mean that the request was a succes
    if (res.statusCode == 200) {
      //Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = jsonDecode(res.body);

      //this line will allow us to get the different articles from the json file and putting them into a list
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
