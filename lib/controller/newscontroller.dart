import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/services/auth.dart';
import 'package:news_app/services/remote_services.dart';

import '../models/articles.dart';

class NewsController extends GetxController {
  final _myBox = Hive.box("mybox");
  AuthService authService = Get.put(AuthService());
  var articleList = <Article?>[].obs;
  var totalRes = 1.obs;
  var status = "".obs;
  var country = "in".obs;
  var category = "general".obs;
  //var welcome = <Welcome>[].obs;

  @override
  void onInit() {
    fetchNews();
    country.value = _myBox.get("Country");
    category.value = _myBox.get("Category");
    if (FirebaseAuth.instance.currentUser == null) authService.signOut();
    super.onInit();
  }

  void fetchNews() async {
    var news = await RemoteServices.fetchNews(
        _myBox.get("Country"), _myBox.get("Category"));
    if (news != null) {
      articleList.value = news.articles!;
      totalRes.value = news.totalResults!;
      status.value = news.status!;
    }
  }

  void changeCountry(var ctr) {
    _myBox.put("Country", ctr);
    country.value = _myBox.get("Country");
  }

  void changeCategory(var ctr) {
    _myBox.put("Category", ctr);
    category.value = _myBox.get("Category");
  }
}
