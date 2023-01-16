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
      actions: [
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

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
