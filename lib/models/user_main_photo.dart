import 'dart:convert';

List<UserMainPhotos> userMainPhotosFromJson(String str) => List<UserMainPhotos>.from(json.decode(str).map((x) => UserMainPhotos.fromJson(x)));

String userMainPhotosToJson(List<UserMainPhotos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserMainPhotos {
  UserMainPhotos({
    this.id,
    this.width,
    this.height,
    this.color,
    this.description,
    this.altDescription,
    this.urls,
  });

  String id;
  int width;
  int height;
  String color;
  dynamic description;
  String altDescription;
  Urls urls;

  factory UserMainPhotos.fromJson(Map<String, dynamic> json) => UserMainPhotos(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    color: json["color"],
    description: json["description"],
    altDescription: json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "color": color,
    "description": description,
    "alt_description": altDescription,
    "urls": urls.toJson(),
  };
}

class Urls {
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json["raw"],
    full: json["full"],
    regular: json["regular"],
    small: json["small"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "full": full,
    "regular": regular,
    "small": small,
    "thumb": thumb,
  };
}
