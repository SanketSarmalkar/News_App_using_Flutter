import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/models/query_types.dart';
import '../controller/newscontroller.dart';
import '../controller/theme_controller.dart';
import 'package:country_icons/country_icons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AppBarMode extends StatefulWidget with PreferredSizeWidget {
  final String title;
  AppBarMode({Key? key, required this.title}) : super(key: key);

  @override
  State<AppBarMode> createState() => _AppBarModeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarModeState extends State<AppBarMode> {
  NewsController newsController = Get.put(NewsController());
  ThemeController themeController = Get.put(ThemeController());

  var query = Queries();

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: themeController.themeColors[0], // Change Custom Drawer Icon Color
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        //backgroundColor: Colors.blue[900],
        backgroundColor: themeController.themeColors[4],
        title: Text(
          widget.title,
          style: TextStyle(
            //color: Colors.blue[300],
            color: themeController.themeColors[0],
            fontFamily: 'avenir',
            fontSize: 40,
            fontWeight: FontWeight.w900,
          ),
        ),

      ),
    );
  }
}

// @override
// Size get preferredSize => const Size.fromHeight(kToolbarHeight);