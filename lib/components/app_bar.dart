import 'package:firebase_auth/firebase_auth.dart';
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
        actions:<Widget> [Builder(
          builder: (BuildContext context) {
            return IconButton(
              // icon: Icon(
              //   Icons.menu,
              //   color: themeController.themeColors[0], // Change Custom Drawer Icon Color
              // ),
              
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  FirebaseAuth.instance.currentUser!.photoURL.toString(),

                  fit: BoxFit.fill,
                  // if the image is null
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        height: 200,
                        width: double.infinity,
                        child: Icon(Icons.person),
                      ),
                    );
                  },
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),],
        leadingWidth: 0,
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