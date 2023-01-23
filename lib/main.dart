import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/init/app_route.dart';
import 'package:news_app/models/themes.dart';
import 'package:news_app/models/user.dart';
import 'package:news_app/screens/home/home.dart';
import 'package:news_app/screens/authentication/login.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final ThemeData _darkTheme = ThemeData(
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserUid?>.value(
      value: AuthService().user,
      initialData: null,
      builder: (context, snapshot) {
        return GetMaterialApp(
          // theme: _lightTheme,
          // darkTheme: _darkTheme,
          // themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initial,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
