import 'package:flutter/material.dart';
import 'package:mews/Models/article.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Values/images.dart';

import '../Pages/ArticlePage/article_page.dart';
import 'custom_text.dart';

Widget customListTile(Article article, BuildContext context) {
  String time = article.publishedAt!.substring(0, 10);
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
      margin: const EdgeInsets.all(12.0),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            child: ClipRRect(
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: AppImage.gifLoading,
                  image: article.urlToImage ?? AppImage.imgDummyUrl),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CustomText(
                  article.source!.name ?? "",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: CustomText(time, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          CustomText(
            article.title ?? "",
            fontWeight: FontWeight.bold,
            fontSize: FontSize.BIG,
          )
        ],
      ),
    ),
  );
}
