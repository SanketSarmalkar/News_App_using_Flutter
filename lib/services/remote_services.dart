import 'package:http/http.dart' as http;
import 'package:news_app/models/articles.dart';
import 'package:news_app/keys/api_key.dart';

class RemoteServices {
  static var client = http.Client();
  APIKey apiKey = APIKey();
  static Future<Welcome?>? fetchNews(var country, var category) async {
    var response = await client.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=${country.toString()}${"&category=$category"}&apiKey=${APIKey.newsApiKey}'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return welcomeFromJson(jsonString);
    } else {
      return null;
    }
  }
}
