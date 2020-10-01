import 'package:FlutterGalleryApp/models/photo.dart' as photoModel;

class PhotoList {
  List<photoModel.Photo> photos;

  PhotoList({this.photos});

  PhotoList.fromJson(List<dynamic> json) {
    photos = List<photoModel.Photo>();
    json.forEach((value) {
      photos.add(photoModel.Photo.fromJson(value as Map<String, dynamic>));
    });
  }

  List<dynamic> toJson() {
    List<dynamic> result = List<dynamic>();

    photos.forEach((element) {
      result.add(element.toJson());
    });

    return result;
  }
}