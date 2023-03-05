import 'package:get/route_manager.dart';
import 'package:get/get.dart';

import '../screens/home/home.dart';
import '../screens/home/news_article.dart';
// ignore: unused_import
import '../screens/authentication/signup.dart';
import '../screens/wrapper.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = '/wrapper';
  static final routes = [
    GetPage(
      name: '/homepage',
      page: () => HomePage(),
    ),
    GetPage(
      name: "/newsArticle",
      page: () => const NewsArticle(),
    ),
    // GetPage(
    //   name: "/login",
    //   page: () => Login(,),
    // ),
    // GetPage(
    //   name: '/signup',
    //   page: () => SignUp(),
    // ),
    GetPage(
      name: '/wrapper',
      page: () => const Wrapper(),
    ),
  ];
}
