// To parse this JSON data, do
//
//     final userLikePhotos = userLikePhotosFromJson(jsonString);

import 'dart:convert';

List<UserLikePhotos> userLikePhotosFromJson(String str) => List<UserLikePhotos>.from(json.decode(str).map((x) => UserLikePhotos.fromJson(x)));

String userLikePhotosToJson(List<UserLikePhotos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserLikePhotos {
  UserLikePhotos({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.likes,
    this.likedByUser,
    this.description,
    this.user,
    this.currentUserCollections,
    this.urls,
    this.links,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int width;
  int height;
  String color;
  String blurHash;
  int likes;
  bool likedByUser;
  String description;
  UserLike user;
  List<CurrentUserCollection> currentUserCollections;
  UrlsLike urls;
  UserLikePhotoLinks links;

  factory UserLikePhotos.fromJson(Map<String, dynamic> json) => UserLikePhotos(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    description: json["description"],
    user: UserLike.fromJson(json["user"]),
    currentUserCollections: List<CurrentUserCollection>.from(json["current_user_collections"].map((x) => CurrentUserCollection.fromJson(x))),
    urls: UrlsLike.fromJson(json["urls"]),
    links: UserLikePhotoLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
    "blur_hash": blurHash,
    "likes": likes,
    "liked_by_user": likedByUser,
    "description": description,
    "user": user.toJson(),
    "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x.toJson())),
    "urls": urls.toJson(),
    "links": links.toJson(),
  };
}

class CurrentUserCollection {
  CurrentUserCollection({
    this.id,
    this.title,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.coverPhoto,
    this.user,
  });

  int id;
  String title;
  DateTime publishedAt;
  DateTime lastCollectedAt;
  DateTime updatedAt;
  dynamic coverPhoto;
  dynamic user;

  factory CurrentUserCollection.fromJson(Map<String, dynamic> json) => CurrentUserCollection(
    id: json["id"],
    title: json["title"],
    publishedAt: DateTime.parse(json["published_at"]),
    lastCollectedAt: DateTime.parse(json["last_collected_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    coverPhoto: json["cover_photo"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "published_at": publishedAt.toIso8601String(),
    "last_collected_at": lastCollectedAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "cover_photo": coverPhoto,
    "user": user,
  };
}

class UserLikePhotoLinks {
  UserLikePhotoLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  String self;
  String html;
  String download;
  String downloadLocation;

  factory UserLikePhotoLinks.fromJson(Map<String, dynamic> json) => UserLikePhotoLinks(
    self: json["self"],
    html: json["html"],
    download: json["download"],
    downloadLocation: json["download_location"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "download": download,
    "download_location": downloadLocation,
  };
}

class UrlsLike {
  UrlsLike({
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

  factory UrlsLike.fromJson(Map<String, dynamic> json) => UrlsLike(
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

class UserLike {
  UserLike({
    this.id,
    this.username,
    this.name,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.totalLikes,
    this.totalPhotos,
    this.totalCollections,
    this.instagramUsername,
    this.twitterUsername,
    this.profileImage,
    this.links,
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
  String instagramUsername;
  String twitterUsername;
  ProfileImageLike profileImage;
  UserLinksLike links;

  factory UserLike.fromJson(Map<String, dynamic> json) => UserLike(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    portfolioUrl: json["portfolio_url"],
    bio: json["bio"],
    location: json["location"],
    totalLikes: json["total_likes"],
    totalPhotos: json["total_photos"],
    totalCollections: json["total_collections"],
    instagramUsername: json["instagram_username"],
    twitterUsername: json["twitter_username"],
    profileImage: ProfileImageLike.fromJson(json["profile_image"]),
    links: UserLinksLike.fromJson(json["links"]),
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
    "instagram_username": instagramUsername,
    "twitter_username": twitterUsername,
    "profile_image": profileImage.toJson(),
    "links": links.toJson(),
  };
}

class UserLinksLike {
  UserLinksLike({
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

  factory UserLinksLike.fromJson(Map<String, dynamic> json) => UserLinksLike(
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

class ProfileImageLike {
  ProfileImageLike({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  String medium;
  String large;

  factory ProfileImageLike.fromJson(Map<String, dynamic> json) => ProfileImageLike(
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
