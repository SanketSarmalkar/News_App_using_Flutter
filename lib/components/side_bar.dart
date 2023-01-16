import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/models/query_types.dart';
import 'package:news_app/models/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/newscontroller.dart';

class SideBarContent extends StatefulWidget {
  SideBarContent({Key? key}) : super(key: key);

  @override
  State<SideBarContent> createState() => _SideBarContentState();
}

class _SideBarContentState extends State<SideBarContent> {
  NewsController newsController = Get.put(NewsController());

  var query = Queries();
  RxBool _isLightTheme = false.obs;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _isLightTheme.value);
  }

  _getThemeStatus() async {
    var _isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : true;
    }).obs;
    _isLightTheme.value = (await _isLight.value)!;
    Get.changeThemeMode(_isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }
  SideBarContent() {
    _getThemeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(240, 13, 71, 161),
          ), //BoxDecoration
          child: UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(100, 13, 71, 161)),
            accountName: Text(
              "Sanket S.Sarmalkar",
              style: TextStyle(fontSize: 18),
            ),
            accountEmail: Text("sanket.sarmalkar2002@gmail.com"),
            currentAccountPictureSize: Size.square(50),
            currentAccountPicture: CircleAvatar(
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
          title: const Text(' My Profile '),
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
                    const Icon(Icons.location_city),
                    Text("Country:"),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: DropdownButtonHideUnderline(
                    child: Obx(
                      ()=> DropdownButton2(
                        value: newsController.country.toString(),
                        dropdownWidth: 125,
                        itemPadding: const EdgeInsets.all(4),

                        items: query.countries
                            .map((String ctr) => DropdownMenuItem(
                          value: ctr,
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(ctr.toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                              ),),
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
                    const Icon(Icons.category),
                    Text("Category:"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: DropdownButtonHideUnderline(
                  child: Obx(
                    ()=> DropdownButton2(
                      value: newsController.category.toString(),
                      dropdownWidth: 125,
                      itemPadding: const EdgeInsets.all(4),
                      items: query.categories
                          .map((String ctr) => DropdownMenuItem(
                        value: ctr,
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(ctr.toString()),
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
        ObxValue(
              (data) => Switch(
            value: _isLightTheme.value,
            onChanged: (val) {
              _isLightTheme.value = val;
              Get.changeThemeMode(
                _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
              );
              _saveThemeStatus();
            },
          ),
          false.obs,
        ),
      ],
    );
  }
}
