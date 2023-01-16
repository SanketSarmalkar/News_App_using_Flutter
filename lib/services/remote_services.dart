import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/articles.dart';

class RemoteServices {
  static var client = http.Client();
  static Future<Welcome?>? fetchNews(var country, var category) async{
    var response = await client.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=${country.toString()}${(category!="none") ?("&category=$category"):""}&apiKey=01970ce6240f47bf97b0a62aa35d70f3'));
    if(response.statusCode == 200){
      var jsonString = response.body;
      return welcomeFromJson(jsonString);
    }else{
      return null;
    }
  }
}