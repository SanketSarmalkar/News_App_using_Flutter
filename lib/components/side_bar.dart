import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/controller/email_info_controller.dart';
import 'package:news_app/controller/theme_controller.dart';
import 'package:news_app/models/query_types.dart';
import 'package:news_app/services/auth.dart';

import '../controller/newscontroller.dart';

class SideBarContent extends StatefulWidget {
  const SideBarContent({Key? key}) : super(key: key);

  @override
  State<SideBarContent> createState() => _SideBarContentState();
}

class _SideBarContentState extends State<SideBarContent> {
  NewsController newsController = Get.put(NewsController());
  ThemeController themeController = Get.put(ThemeController());
  EmailInfoController emailInfoController = Get.put(EmailInfoController());
  final AuthService authService = AuthService();
  var myBox = Hive.box('mybox');

  var query = Queries();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: themeController.themeColors[4],
        ),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: themeController.themeColors[1],
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: themeController.themeColors[1],
                ),
                accountName: Text(
                  //emailInfoController.name.toString(),
                  (FirebaseAuth.instance.currentUser!.displayName != null)
                      ? FirebaseAuth.instance.currentUser!.displayName
                          .toString()
                      : FirebaseAuth.instance.currentUser!.email
                          .toString()
                          .substring(
                              0,
                              FirebaseAuth.instance.currentUser!.email
                                  .toString()
                                  .indexOf('@')),
                  style: TextStyle(
                    color: themeController.themeColors[0],
                    fontSize: 18,
                  ),
                ),
                accountEmail: Text(
                  //emailInfoController.email.toString(),
                  FirebaseAuth.instance.currentUser!.email.toString(),
                  style: TextStyle(color: themeController.themeColors[0]),
                ),
                currentAccountPictureSize: const Size.square(50),
                // currentAccountPicture: CircleAvatar(
                //   backgroundColor: Colors.indigo,
                //   child: Text(
                //     FirebaseAuth.instance.currentUser!.displayName.toString()[0].toUpperCase(),
                //     style: const TextStyle(fontSize: 30.0, color: Colors.blue),
                //   ), //Text
                // ), //circleAvatar
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL.toString(),
                    fit: BoxFit.fill,
                    // if the image is null
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Icon(Icons.person),
                        ),
                      );
                    },
                  ),
                ),
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
                        Icon(
                          Icons.location_pin,
                          color: themeController.themeColors[0],
                        ),
                        Text(
                          "Country:",
                          style:
                              TextStyle(color: themeController.themeColors[0]),
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
                          dropdownDecoration: BoxDecoration(
                            color: themeController.themeColors[4],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          items: query.countries
                              .map((String ctr) => DropdownMenuItem(
                                    value: ctr,
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          ctr.toString(),
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color:
                                                themeController.themeColors[0],
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
                        Icon(
                          Icons.category,
                          color: themeController.themeColors[0],
                        ),
                        Text(
                          "Category:",
                          style:
                              TextStyle(color: themeController.themeColors[0]),
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
                          dropdownDecoration: BoxDecoration(
                            color: themeController.themeColors[4],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          items: query.categories
                              .map((String ctr) => DropdownMenuItem(
                                    value: ctr,
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Center(
                                          child: Text(
                                            ctr.toString(),
                                            style: TextStyle(
                                              color: themeController
                                                  .themeColors[0],
                                              backgroundColor: themeController
                                                  .themeColors[4],
                                            ),
                                          ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.mode_night,
                    color: themeController.themeColors[0],
                  ),
                  /* ObxValue(
                    (data) =>*/
                  Switch(
                    // ignore: unrelated_type_equality_checks
                    value: (myBox.get("Theme") == "light") ? true : false,
                    onChanged: (val) {
                      themeController.changeTheme();
                      // ignore: unrelated_type_equality_checks
                      // Get.changeThemeMode((themeController.theme != "light")
                      //     ? ThemeMode.light
                      //     : ThemeMode.dark);
                      //print(themeController.theme);
                    },
                  ),
                  /*false.obs,
                  ),*/
                  Icon(
                    Icons.wb_sunny,
                    color: themeController.themeColors[0],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // <-- Radius
                ),
                onPressed: () async {
                  dynamic result = await authService.signOut();
                  if (result != null) {
                    Get.snackbar(
                      "Error",
                      "Error occured during Signing Out, Try Again",
                      icon: const Icon(Icons.error, color: Colors.white),
                      backgroundColor: Colors.black12,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    Get.snackbar(
                      "Success",
                      "Signed Out Successfully",
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      backgroundColor: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                color: const Color.fromARGB(240, 13, 71, 161),
                child: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Center(
              child: Text(
                "Developed By: Sanket S.Sarmalkar",
                style: TextStyle(
                    color: themeController.themeColors[0],
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
