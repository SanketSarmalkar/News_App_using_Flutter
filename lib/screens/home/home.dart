import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:news_app/components/app_bar.dart';
import 'package:news_app/controller/theme_controller.dart';
import 'package:news_app/models/query_types.dart';
import '../../components/side_bar.dart';
import '../../controller/newscontroller.dart';
import 'package:animated_card/animated_card.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  NewsController newsController = Get.put(NewsController());

  ThemeController themeController = Get.put(ThemeController());

  var query = Queries();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        //backgroundColor: Colors.blue[400],
        backgroundColor: themeController.themeColors[3],
        endDrawer: const Drawer(
          child: SideBarContent(),
        ),
        appBar: AppBarMode(
          title: "NewsApp",
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeController.themeColors[3],
                ),
                alignment: Alignment.center,
                //color: Colors.blue[600],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Top Headlines",
                    style: TextStyle(
                      color: themeController.themeColors[0],
                      fontFamily: 'avenir',
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragDown: (context) {
                  newsController.fetchNews();
                },
                child: Obx(
                  () => Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: MasonryGridView.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                        itemCount: newsController.articleList.length,
                        itemBuilder: (context, index) {
                          return AnimatedCard(
                            child: Card(
                              // elevation: 50,
                              // shadowColor: Colors.black,
                              // color: Colors.blue[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              color: themeController.themeColors[2],
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      newsController
                                              .articleList[index]?.urlToImage
                                              .toString() ??
                                          "",
                                      fit: BoxFit.fill,
                                      // if the image is null
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const SizedBox(
                                            height: 200,
                                            width: double.infinity,
                                            child: Icon(
                                                Icons.broken_image_outlined),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      newsController.articleList[index]!.title
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 25,
                                        //color: Colors.blue[50],
                                        color: themeController.themeColors[0],
                                        fontWeight: FontWeight.w500,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Published On : ${newsController.articleList[index]!.publishedAt.toString().substring(0, 19)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          //color: Colors.blue[100],
                                          color:
                                              themeController.themeColors[0]),
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      (newsController.articleList[index]!
                                                  .description
                                                  .toString() !=
                                              "")
                                          ? newsController
                                              .articleList[index]!.description
                                              .toString()
                                          : "",
                                      style: TextStyle(
                                          fontSize: 15,
                                          //color: Colors.blue[100],
                                          color:
                                              themeController.themeColors[0]),
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              Get.toNamed(
                                                  "/newsArticle?websiteUrl=${newsController.articleList[index]!.url.toString()}");
                                            },
                                            //color: Colors.blue[800],
                                            color:
                                                themeController.themeColors[0],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Read More',
                                                    style: TextStyle(
                                                        //color: Colors.blue[50],
                                                        color: themeController
                                                            .themeColors[4]),
                                                  ),
                                                ],
                                              ), //Row
                                            ), //Padding
                                          ),
                                        ]) //SizedBox
                                  ],
                                ), //Column
                              ), //SizedBox
                            ),
                          );
                        }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
