import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/app_bar.dart';
import '../components/news_content.dart';

class NewsArticle extends StatefulWidget {
  const NewsArticle({Key? key}) : super(key: key);

  @override
  State<NewsArticle> createState() => _NewsArticleState();
}

class _NewsArticleState extends State<NewsArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMode(title: "",),
      body: WebViewApp(websiteUrl: Get.parameters['websiteUrl']!,),
      );
  }
}


