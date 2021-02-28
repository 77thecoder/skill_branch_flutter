import 'dart:convert';

import 'package:FlutterGalleryApp/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider {
  static const ACCESS_KEY = 'al9jb32GUwrQba57OC1g3NpRr98eunzhXUb7imUpG5s';
  static const SECRET_KEY = 'q-B6MqHEflZLqFe8qmdkKsctUXIE96YqLLkcxDv5At0';
  static const UNSPLASH_URL = 'https://api.unsplash.com';
  static String token;
  static const HEADER = {'Authorization': 'Client-ID $ACCESS_KEY'};
  static PhotoList list;

  /// Получение токена
  static Future<String> getAuthToken() async {
    final baseAuthUrl = 'https://unsplash.com/oauth/authorize';
    final callbackUrlScheme = 'galleryapp';
    final redirectUrl = Uri.parse('galleryapp://callback');
    final scope = 'public+write_likes';

    final url = Uri.https('unsplash.com', 'oauth/authorize', {
      'response_type': 'code',
      'client_id': ACCESS_KEY,
      'redirect_uri': 'galleryapp://callback',
      'scope': scope,
    });

    final result = await FlutterWebAuth.authenticate(
        url: url
            .toString()
            .replaceAll("%2B", "+"),
        callbackUrlScheme: callbackUrlScheme);

    final code = Uri.parse(result).queryParameters['code'];

    final baseTokenUrl = 'https://unsplash.com/oauth/token';
    final body = {
      'client_id': ACCESS_KEY,
      'client_secret': SECRET_KEY,
      'redirect_uri': 'galleryapp://callback',
      'code': code,
      'grant_type': 'authorization_code',
    };
    try {
      var response = await http.post(
        baseTokenUrl,
        body: body,
      );
      DataProvider.token = jsonDecode(response.body)['access_token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(token, DataProvider.token);
      return jsonDecode(response.body)['access_token'];
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Список фотографий
  static Future<PhotoList> getPhotos(int page, int perPage) async {
    print('load photos page: $page, perPage: $perPage');
    String urlGetPhotos = '$UNSPLASH_URL/photos?page=$page&per_page=$perPage';
    String url = urlGetPhotos + '&page=$page&per_page=$perPage';
    var response = await http.get(url, headers: {'Authorization': 'Bearer ' + DataProvider.token});
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

  /// Получить url для скачивания фото
  static Future<String> getUrlDownload(String id) async {
    print('get url download photo');
    String url = '$UNSPLASH_URL/photos/$id/download';
    var response = await http.get(url, headers: HEADER);
    print('loaded related photos');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['url'];
    } else {
      throw Exception("Couldn't get url download: ${response.reasonPhrase}");
    }
  }

  /// Поиск фотографий
  static Future<PhotoList> searchPhotos(String query, int page, int perPage) async {
    print('load search photos');
    String urlSearchPhotos = 'https://api.unsplash.com/search/photos';
    String url = urlSearchPhotos + '?query=$query&page=$page&per_page=$perPage';
    var response = await http.get(url, headers: HEADER);
    print('loaded search photos');
    if (response.statusCode == 200) {
      // RelatedPhotos related = relatedPhotosFromJson(response.body);
      Map<String, dynamic> data = json.decode(response.body);
      String photos = json.encode(data['results']);
      return PhotoList.fromJson(data['results']);
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }
}