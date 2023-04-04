import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/theme_controller.dart';

import '../../components/news_content.dart';

class NewsArticle extends StatefulWidget {
  const NewsArticle({Key? key}) : super(key: key);

  @override
  State<NewsArticle> createState() => _NewsArticleState();
}

class _NewsArticleState extends State<NewsArticle> {
  ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blue[900],
        backgroundColor: themeController.themeColors[4],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: themeController
                    .themeColors[0], // Change Custom Drawer Icon Color
              ),
              onPressed: () {
                Get.back();
              },
            );
          },
        ),
      ),
      body: WebViewApp(
        websiteUrl: Get.parameters['websiteUrl']!,
      ),
    );
  }
}
