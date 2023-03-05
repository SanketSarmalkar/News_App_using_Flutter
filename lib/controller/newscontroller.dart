import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:news_app/services/auth.dart';
import 'package:news_app/services/remote_services.dart';

import '../models/articles.dart';

class NewsController extends GetxController {
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
    if (FirebaseAuth.instance.currentUser == null) authService.signOut();
    super.onInit();
  }

  void fetchNews() async {
    var news = await RemoteServices.fetchNews(country, category);
    if (news != null) {
      articleList.value = news.articles!;
      totalRes.value = news.totalResults!;
      status.value = news.status!;
    }
  }

  void changeCountry(var ctr) {
    country.value = ctr;
  }

  void changeCategory(var ctr) {
    category.value = ctr;
  }
}
