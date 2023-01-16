import 'package:flutter/material.dart';
import 'package:news_app/init/app_route.dart';
import 'package:news_app/screens/home.dart';
import 'package:news_app/screens/login.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
