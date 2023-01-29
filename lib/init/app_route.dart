import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/authentication/authentication_wrapper.dart';

import '../screens/home/home.dart';
import '../screens/authentication/login.dart';
import '../screens/home/news_article.dart';
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
      page: () => NewsArticle(),
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
      page: () => Wrapper(),
    ),
  ];
}
