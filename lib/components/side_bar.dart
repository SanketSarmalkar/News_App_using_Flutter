import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/models/query_types.dart';

import '../controller/newscontroller.dart';

class SideBarContent extends StatelessWidget {
  SideBarContent({Key? key}) : super(key: key);
  NewsController newsController = Get.put(NewsController());
  var query = Queries();

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
              Text("Country: "),
              Obx(
                    () => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      dropdownWidth: 125,
                      itemPadding: const EdgeInsets.all(4),
                      icon: Image.asset(
                        'icons/flags/png/${newsController.country}.png',
                        package: 'country_icons',
                        height: 20,
                        width: 30,
                      ),
                      items: query.countries
                          .map((String ctr) => DropdownMenuItem(
                        value: ctr,
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image.asset(
                              'icons/flags/png/$ctr.png',
                              package: 'country_icons',
                              height: 20,
                              width: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(ctr.toString()),
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
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              const Text("Category:"),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
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
            ],
          ),
        )
      ],
    );
  }
}
