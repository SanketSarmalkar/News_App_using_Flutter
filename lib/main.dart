import 'package:flutter/material.dart';
import 'package:news_app/init/app_route.dart';
import 'package:news_app/models/themes.dart';
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
  final ThemeData _darkTheme = ThemeData(
      accentColor: Colors.red,
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.amber,
        disabledColor: Colors.grey,
      ));

  final ThemeData _lightTheme = ThemeData(
      accentColor: Colors.pink,
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        disabledColor: Colors.grey,
      ));
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: _lightTheme,
      // darkTheme: _darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
