// To parse this JSON data, do
//
//     final userFavoritePhotos = userFavoritePhotosFromJson(jsonString);

import 'dart:convert';

List<UserFavoritePhotos> userFavoritePhotosFromJson(String str) => List<UserFavoritePhotos>.from(json.decode(str).map((x) => UserFavoritePhotos.fromJson(x)));

String userFavoritePhotosToJson(List<UserFavoritePhotos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserFavoritePhotos {
  UserFavoritePhotos({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.coverPhoto,
    this.user,
    this.links,
  });

  String id;
  String title;
  String description;
  DateTime publishedAt;
  DateTime lastCollectedAt;
  DateTime updatedAt;
  int totalPhotos;
  bool private;
  String shareKey;
  CoverPhotoFavorite coverPhoto;
  UserFavorite user;
  UserFavoritePhotoLinks links;

  factory UserFavoritePhotos.fromJson(Map<String, dynamic> json) => UserFavoritePhotos(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    publishedAt: DateTime.parse(json["published_at"]),
    lastCollectedAt: DateTime.parse(json["last_collected_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    totalPhotos: json["total_photos"],
    private: json["private"],
    shareKey: json["share_key"],
    coverPhoto: CoverPhotoFavorite.fromJson(json["cover_photo"]),
    user: UserFavorite.fromJson(json["user"]),
    links: UserFavoritePhotoLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "published_at": publishedAt.toIso8601String(),
    "last_collected_at": lastCollectedAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "total_photos": totalPhotos,
    "private": private,
    "share_key": shareKey,
    "cover_photo": coverPhoto.toJson(),
    "user": user.toJson(),
    "links": links.toJson(),
  };
}

class CoverPhotoFavorite {
  CoverPhotoFavorite({
    this.id,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.likes,
    this.likedByUser,
    this.description,
    this.user,
    this.urls,
    this.links,
  });

  String id;
  int width;
  int height;
  String color;
  String blurHash;
  int likes;
  bool likedByUser;
  String description;
  UserFavorite user;
  UrlsFavorite urls;
  CoverPhotoLinksFavorite links;

  factory CoverPhotoFavorite.fromJson(Map<String, dynamic> json) => CoverPhotoFavorite(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    description: json["description"],
    user: UserFavorite.fromJson(json["user"]),
    urls: UrlsFavorite.fromJson(json["urls"]),
    links: CoverPhotoLinksFavorite.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "color": color,
    "blur_hash": blurHash,
    "likes": likes,
    "liked_by_user": likedByUser,
    "description": description,
    "user": user.toJson(),
    "urls": urls.toJson(),
    "links": links.toJson(),
  };
}

class CoverPhotoLinksFavorite {
  CoverPhotoLinksFavorite({
    this.self,
    this.html,
    this.download,
  });

  String self;
  String html;
  String download;

  factory CoverPhotoLinksFavorite.fromJson(Map<String, dynamic> json) => CoverPhotoLinksFavorite(
    self: json["self"],
    html: json["html"],
    download: json["download"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "download": download,
  };
}

class UrlsFavorite {
  UrlsFavorite({
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

  factory UrlsFavorite.fromJson(Map<String, dynamic> json) => UrlsFavorite(
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

class UserFavorite {
  UserFavorite({
    this.id,
    this.username,
    this.name,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.totalLikes,
    this.totalPhotos,
    this.totalCollections,
    this.profileImage,
    this.links,
    this.updatedAt,
  });

  String id;
  String username;
  String name;
  String portfolioUrl;
  String bio;
  String location;
  int totalLikes;
  int totalPhotos;
  int totalCollections;
  ProfileImageFavorite profileImage;
  UserLinksFavorite links;
  DateTime updatedAt;

  factory UserFavorite.fromJson(Map<String, dynamic> json) => UserFavorite(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    portfolioUrl: json["portfolio_url"],
    bio: json["bio"],
    location: json["location"],
    totalLikes: json["total_likes"],
    totalPhotos: json["total_photos"],
    totalCollections: json["total_collections"],
    profileImage: ProfileImageFavorite.fromJson(json["profile_image"]),
    links: UserLinksFavorite.fromJson(json["links"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
    "portfolio_url": portfolioUrl,
    "bio": bio,
    "location": location,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "total_collections": totalCollections,
    "profile_image": profileImage.toJson(),
    "links": links.toJson(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class UserLinksFavorite {
  UserLinksFavorite({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
  });

  String self;
  String html;
  String photos;
  String likes;
  String portfolio;

  factory UserLinksFavorite.fromJson(Map<String, dynamic> json) => UserLinksFavorite(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    likes: json["likes"],
    portfolio: json["portfolio"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "likes": likes,
    "portfolio": portfolio,
  };
}

class ProfileImageFavorite {
  ProfileImageFavorite({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  String medium;
  String large;

  factory ProfileImageFavorite.fromJson(Map<String, dynamic> json) => ProfileImageFavorite(
    small: json["small"],
    medium: json["medium"],
    large: json["large"],
  );

  Map<String, dynamic> toJson() => {
    "small": small,
    "medium": medium,
    "large": large,
  };
}

class UserFavoritePhotoLinks {
  UserFavoritePhotoLinks({
    this.self,
    this.html,
    this.photos,
    this.related,
  });

  String self;
  String html;
  String photos;
  String related;

  factory UserFavoritePhotoLinks.fromJson(Map<String, dynamic> json) => UserFavoritePhotoLinks(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    related: json["related"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "related": related,
  };
}
