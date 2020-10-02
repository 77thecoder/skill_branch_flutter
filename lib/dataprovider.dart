import 'dart:convert';

import 'package:FlutterGalleryApp/models/photo_list.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  static const String client_id = 'al9jb32GUwrQba57OC1g3NpRr98eunzhXUb7imUpG5s';
  static const String urlGetPhotos = 'https://api.unsplash.com/photos?client_id=$client_id';
  static PhotoList list;

  static Future<PhotoList> getPhotos(int page, int perPage) async {
    print('load photos page: $page, perPage: $perPage');
    String url = urlGetPhotos + '&page=$page&per_page=$perPage';
    var response = await http.get(url);
    print('photos loaded');
    if (response.statusCode == 200) {
      return PhotoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}