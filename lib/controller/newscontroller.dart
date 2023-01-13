import 'package:get/state_manager.dart';
import 'package:news_app/services/remote_services.dart';

import '../models/articles.dart';

class NewsController extends GetxController{
  var articleList = <Article?>[].obs;
  var totalRes = 1.obs;
  var status = "".obs;
  //var welcome = <Welcome>[].obs;

  @override
  void onInit(){
    fetchNews();
    super.onInit();
  }

  void fetchNews() async{
     var news = await RemoteServices.fetchNews();
     if(news != null){
       articleList.value = news.articles!;
       totalRes.value = news.totalResults!;
       status.value = news.status!;
     }
  }
}