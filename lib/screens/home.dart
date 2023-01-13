import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:news_app/models/articles.dart';
import '../controller/newscontroller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          "NEWSAPP",
          style: TextStyle(
            color: Colors.blue[300],
            fontFamily: 'avenir',
            fontSize: 40,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue[600],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Top Headlines",
                  style: TextStyle(
                    fontFamily: 'avenir',
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8,
                    itemCount: newsController.articleList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 50,
                        shadowColor: Colors.black,
                        color: Colors.blue[600],
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Image.network(
                                newsController.articleList[index]?.urlToImage
                                        .toString() ??
                                    "",
                                fit: BoxFit.fill,
                                // if the image is null
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: Icon(Icons.broken_image_outlined),
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
                                  color: Colors.blue[100],
                                  fontWeight: FontWeight.w500,
                                ), //Textstyle
                              ), //Text
                              const SizedBox(
                                height: 10,
                              ), //SizedBox
                              Text(
                                newsController.articleList[index]!.description
                                        .toString() ??
                                    "",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue[200],
                                ),
                              ), //Text
                              const SizedBox(
                                height: 10,
                              ), //SizedBox
                              // SizedBox(
                              //   width: 100,
                              //
                              //   child: ElevatedButton(
                              //     onPressed: () => 'Null',
                              //     style: ButtonStyle(
                              //         backgroundColor:
                              //         MaterialStateProperty.all(Colors.green)),
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(4),
                              //       child: Row(
                              //         children: const [
                              //           Icon(Icons.touch_app),
                              //           Text('Visit')
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              //   // RaisedButton is deprecated and should not be used
                              //   // Use ElevatedButton instead
                              //
                              //   // child: RaisedButton(
                              //   //   onPressed: () => null,
                              //   //   color: Colors.green,
                              //   //   child: Padding(
                              //   //     padding: const EdgeInsets.all(4.0),
                              //   //     child: Row(
                              //   //       children: const [
                              //   //         Icon(Icons.touch_app),
                              //   //         Text('Visit'),
                              //   //       ],
                              //   //     ), //Row
                              //   //   ), //Padding
                              //   // ), //RaisedButton
                              // ) //SizedBox
                            ],
                          ), //Column
                        ), //SizedBox
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
