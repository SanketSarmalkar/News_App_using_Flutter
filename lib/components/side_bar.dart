import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/theme_controller.dart';
import 'package:news_app/models/query_types.dart';
import 'package:news_app/models/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/newscontroller.dart';

class SideBarContent extends StatefulWidget {
  const SideBarContent({Key? key}) : super(key: key);

  @override
  State<SideBarContent> createState() => _SideBarContentState();
}

class _SideBarContentState extends State<SideBarContent> {
  NewsController newsController = Get.put(NewsController());
  ThemeController themeController = Get.put(ThemeController());

  var query = Queries();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeController.themeColors[4],
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(240, 13, 71, 161),
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(100, 13, 71, 161)),
              accountName: Text(
                "Sanket S.Sarmalkar",
                style: TextStyle(
                  color: themeController.themeColors[0],
                  fontSize: 18,
                ),
              ),
              accountEmail: Text(
                "sanket.sarmalkar2002@gmail.com",
                style: TextStyle(color: themeController.themeColors[0]),
              ),
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text(
                  "SS",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(Icons.person),
            iconColor: themeController.themeColors[0],
            title: Text(
              ' My Profile ',
              style: TextStyle(color: themeController.themeColors[0]),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_pin,color: themeController.themeColors[0],),
                      Text(
                        "Country:",
                        style: TextStyle(color: themeController.themeColors[0]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: DropdownButtonHideUnderline(
                    child: Obx(
                      () => DropdownButton2(
                        value: newsController.country.toString(),
                        dropdownWidth: 125,
                        itemPadding: const EdgeInsets.all(4),
                        items: query.countries
                            .map((String ctr) => DropdownMenuItem(
                                  value: ctr,
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        ctr.toString(),
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        'icons/flags/png/$ctr.png',
                                        package: 'country_icons',
                                        height: 20,
                                        width: 30,
                                      ),
                                    ),
                                  ]),
                                ))
                            .toList(),
                        onChanged: (ctr) {
                          newsController.changeCountry(ctr);
                          newsController.fetchNews();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.category, color: themeController.themeColors[0],),
                      Text(
                        "Category:",
                        style: TextStyle(color: themeController.themeColors[0]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: DropdownButtonHideUnderline(
                    child: Obx(
                      () => DropdownButton2(
                        value: newsController.category.toString(),
                        dropdownWidth: 125,
                        itemPadding: const EdgeInsets.all(4),
                        itemSplashColor: themeController.themeColors[4],
                        items: query.categories
                            .map((String ctr) => DropdownMenuItem(
                                  value: ctr,
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        ctr.toString(),
                                        ),
                                    ),
                                  ]),
                                ))
                            .toList(),
                        onChanged: (ctr) {
                          newsController.changeCategory(ctr);
                          newsController.fetchNews();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              children: [
                Text(
                  '${themeController.theme.toString()[0].toUpperCase()+themeController.theme.toString().substring(1,themeController.theme.toString().length)} Mode Enabled',
                  style: TextStyle(color: themeController.themeColors[0]),
                ),
                ObxValue(
                  (data) => Switch(
                    value: (themeController.theme == "light") ? true : false,
                    onChanged: (val) {
                      themeController.changeTheme();
                      Get.changeThemeMode((themeController.theme != "light")
                          ? ThemeMode.light
                          : ThemeMode.dark);
                      print(themeController.theme);
                    },
                  ),
                  false.obs,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
