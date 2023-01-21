import 'package:flutter/material.dart';
import '../models/theme_data.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController{
  final colorCollection = ThemeColorData();
  var theme = "light".obs;
  var themeColors = [
    Colors.black,
    Colors.white24,
    Colors.white38,
    Colors.white60,
    Colors.white,
  ].obs;


  void changeTheme(){
    theme.value = (theme.value=='light')?"dark":"light";
    themeColors.value = (theme.value=='light')?colorCollection.lightColor:colorCollection.darkColor;
    print(themeColors);
  }
}