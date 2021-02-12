import 'dart:convert';

import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/models/photo_list.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  static const ACCESS_KEY = 'al9jb32GUwrQba57OC1g3NpRr98eunzhXUb7imUpG5s';
  static const SECRET_KEY = 'q-B6MqHEflZLqFe8qmdkKsctUXIE96YqLLkcxDv5At0';
  static const UNSPLASH_URL = 'https://api.unsplash.com';
  static const HEADER = {'Authorization': 'Client-ID $ACCESS_KEY'};

  static PhotoList list;

  static Future<PhotoList> getPhotos(int page, int perPage) async {
    print('load photos page: $page, perPage: $perPage');
    String urlGetPhotos = '$UNSPLASH_URL/photos?page=$page&per_page=$perPage';
    String url = urlGetPhotos + '&page=$page&per_page=$perPage';
    var response = await http.get(url, headers: HEADER);
    print('photos loaded');
    if (response.statusCode == 200) {
      return PhotoList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }

  static Future<UserModel> user(String username) async {
    print('get profile user $username');
    String url = '$UNSPLASH_URL/users/$username';
    var response = await http.get(url, headers: HEADER);
    print('profile user completed');
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }
}