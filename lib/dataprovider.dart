import 'dart:convert';

import 'package:FlutterGalleryApp/models/models.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  static const ACCESS_KEY = 'al9jb32GUwrQba57OC1g3NpRr98eunzhXUb7imUpG5s';
  static const SECRET_KEY = 'q-B6MqHEflZLqFe8qmdkKsctUXIE96YqLLkcxDv5At0';
  static const UNSPLASH_URL = 'https://api.unsplash.com';
  static const HEADER = {'Authorization': 'Client-ID $ACCESS_KEY'};

  static PhotoList list;

  /// Список фотографий
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

  /// Информация об юзере
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

  /// Фотографии пользователя
  static Future<PhotoList> getUserMainPhotos(String username, int page, int perPage) async {
    print('get user main photos');
    String url = '$UNSPLASH_URL/users/$username/photos?page=$page&per_page=$perPage';
    var response = await http.get(url, headers: HEADER);
    print('user main photos loaded');
    if (response.statusCode == 200) {
      List<UserMainPhotos> mainPhotos = userMainPhotosFromJson(response.body);
      String j = json.encode(mainPhotos);
      var s = PhotoList.fromJson(json.decode(j));
      return s;
    } else {
      throw Exception("Couldn't get main photos users: ${response.reasonPhrase}");
    }
  }

  /// Понравившиеся фотографии
  static Future<PhotoList> getUserLikePhotos(String username, int page, int perPage) async {
    print('get user like photos');
    String url = '$UNSPLASH_URL/users/$username/likes?page=$page&per_page=$perPage';
    var response = await http.get(url, headers: HEADER);
    print('user like photos loaded');
    if (response.statusCode == 200) {
      List<UserLikePhotos> likePhotos = userLikePhotosFromJson(response.body);
      String j = json.encode(likePhotos);
      var s = PhotoList.fromJson(json.decode(j));
      return s;
    } else {
      throw Exception("Couldn't get like photos users: ${response.reasonPhrase}");
    }
  }

  /// Коллекции фотографий юзера
  static Future<List<UserFavoritePhotos>> getUserFavoritePhotos(String username, int page, int perPage) async {
    print('get user favorite photos');
    String url = '$UNSPLASH_URL/users/$username/collections?page=$page&per_page=$perPage';
    var response = await http.get(url, headers: HEADER);
    print('user main photos loaded');
    if (response.statusCode == 200) {
      return userFavoritePhotosFromJson(response.body);
    } else {
      throw Exception("Couldn't get favorite photos users: ${response.reasonPhrase}");
    }
  }

  /// Список фотографий
  static Future<PhotoList> getRelatedPhotos(String photo_id) async {
    print('load related photos');
    String urlRelatedPhotos = 'https://unsplash.com/napi/photos';
    String url = urlRelatedPhotos + '/$photo_id/related';
    var response = await http.get(url);
    print('loaded related photos');
    if (response.statusCode == 200) {
      RelatedPhotos related = relatedPhotosFromJson(response.body);
      String j = json.encode(related.results);
      var s = PhotoList.fromJson(json.decode(j));
      return s;
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }

  /// Фото по ID
  static Future<Photo> getPhoto(String id) async {
    print('load photo by id');
    String url = '$UNSPLASH_URL/photos/$id';
    var response = await http.get(url, headers: HEADER);
    print('loaded related photos');
    if (response.statusCode == 200) {
      return Photo.fromJson(json.decode(response.body));
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }
}