import 'package:mews/Models/source.dart';

class Article {
  String? id;
  String? newname;
  String? title;
  String? url;
  String? imageurl;
  String? category;
  String? time;

  Article(
      {this.id,
      this.newname,
      this.title,
      this.category,
      this.url,
      this.imageurl,
      this.time});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['_id'],
        url: json['url'],
        title: json['title'],
        category: json['category'],
        imageurl: json['imageurl'],
        time: json['time'],
        newname: json['newname']);
  }

  factory Article.fromJsonDynamic(dynamic json) {
    return Article(
      id: json['_id'],
      url: json['url'],
      title: json['title'],
      category: json['category'],
      imageurl: json['imageurl'],
      time: json['time'],
      newname: json['newname'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['_id'] = id;
    map['url'] = url;
    map['title'] = title;
    map['category'] = category;
    map['imageurl'] = imageurl;
    map['time'] = time;
    map['newname'] = newname;
    return map;
  }
}
