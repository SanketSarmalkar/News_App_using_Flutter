import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/models/query_types.dart';
import '../controller/newscontroller.dart';
import 'package:country_icons/country_icons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AppBarMode extends StatelessWidget with PreferredSizeWidget {
  final String title;
  AppBarMode({Key? key, required this.title}) : super(key: key);
  NewsController newsController = Get.put(NewsController());
  var query = Queries();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[900],
      title: Text(
        title,
        style: TextStyle(
          color: Colors.blue[300],
          fontFamily: 'avenir',
          fontSize: 40,
          fontWeight: FontWeight.w900,
        ),
      ),

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
