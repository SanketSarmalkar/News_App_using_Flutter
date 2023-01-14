import 'package:get/route_manager.dart';
import 'package:get/get.dart';

import '../screens/home.dart';
import '../screens/news_article.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = '/homepage';
  static final routes = [
    GetPage(
      name: '/homepage',
      page: () => HomePage(),
    ),
    GetPage(
      name: "/newsArticle",
      page: () => NewsArticle(),
    )
  ];
}
