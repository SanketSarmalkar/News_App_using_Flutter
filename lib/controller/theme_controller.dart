import 'package:flutter/material.dart';
import '../models/theme_data.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  final colorCollection = ThemeColorData();
  var theme = "light".obs;
  final mybox = Hive.box('mybox');
  var themeColors = [
    Colors.black,
    Colors.black26,
    Colors.white38,
    Colors.white60,
    Colors.white,
  ].obs;

  @override
  void onInit() {
    super.onInit();
    //theme.value = mybox.get('Theme');
    themeColors.value = (mybox.get("Theme") == 'light')
        ? colorCollection.lightColor
        : colorCollection.darkColor;
  }

  void changeTheme() {
    //theme.value = (theme.value == 'light') ? "dark" : "light";
    mybox.put("Theme", mybox.get("Theme") == 'light' ? "dark" : "light");
    themeColors.value = (mybox.get("Theme") == 'light')
        ? colorCollection.lightColor
        : colorCollection.darkColor;
    //print(themeColors);
  }
}
