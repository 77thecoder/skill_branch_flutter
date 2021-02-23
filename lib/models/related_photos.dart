// To parse this JSON data, do
//
//     final relatedPhotos = relatedPhotosFromJson(jsonString);

import 'dart:convert';

RelatedPhotos relatedPhotosFromJson(String str) => RelatedPhotos.fromJson(json.decode(str));

String relatedPhotosToJson(RelatedPhotos data) => json.encode(data.toJson());

class RelatedPhotos {
  RelatedPhotos({
    this.total,
    this.results,
  });

  int total;
  List<ResultRelated> results;

  factory RelatedPhotos.fromJson(Map<String, dynamic> json) => RelatedPhotos(
    total: json["total"],
    results: List<ResultRelated>.from(json["results"].map((x) => ResultRelated.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class ResultRelated {
  ResultRelated({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.user,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  String description;
  String altDescription;
  UrlsRelated urls;
  ResultLinksRelated links;
  List<dynamic> categories;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  UserRelated user;

  factory ResultRelated.fromJson(Map<String, dynamic> json) => ResultRelated(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"] == null ? null : DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    description: json["description"] == null ? null : json["description"],
    altDescription: json["alt_description"] == null ? null : json["alt_description"],
    urls: UrlsRelated.fromJson(json["urls"]),
    links: ResultLinksRelated.fromJson(json["links"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    sponsorship: json["sponsorship"],
    user: UserRelated.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "promoted_at": promotedAt == null ? null : promotedAt.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
    "blur_hash": blurHash,
    "description": description == null ? null : description,
    "alt_description": altDescription == null ? null : altDescription,
    "urls": urls.toJson(),
    "links": links.toJson(),
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "likes": likes,
    "liked_by_user": likedByUser,
    "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x)),
    "sponsorship": sponsorship,
    "user": user.toJson(),
  };
}

class ResultLinksRelated {
  ResultLinksRelated({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  String self;
  String html;
  String download;
  String downloadLocation;

  factory ResultLinksRelated.fromJson(Map<String, dynamic> json) => ResultLinksRelated(
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

class UrlsRelated {
  UrlsRelated({
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

  factory UrlsRelated.fromJson(Map<String, dynamic> json) => UrlsRelated(
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

class UserRelated {
  UserRelated({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
  });

  String id;
  DateTime updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  String twitterUsername;
  String portfolioUrl;
  String bio;
  String location;
  UserLinksRelated links;
  ProfileImageRelated profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;

  factory UserRelated.fromJson(Map<String, dynamic> json) => UserRelated(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["username"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    twitterUsername: json["twitter_username"] == null ? null : json["twitter_username"],
    portfolioUrl: json["portfolio_url"] == null ? null : json["portfolio_url"],
    bio: json["bio"] == null ? null : json["bio"],
    location: json["location"] == null ? null : json["location"],
    links: UserLinksRelated.fromJson(json["links"]),
    profileImage: ProfileImageRelated.fromJson(json["profile_image"]),
    instagramUsername: json["instagram_username"],
    totalCollections: json["total_collections"],
    totalLikes: json["total_likes"],
    totalPhotos: json["total_photos"],
    acceptedTos: json["accepted_tos"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
    "username": username,
    "name": name,
    "first_name": firstName,
    "last_name": lastName == null ? null : lastName,
    "twitter_username": twitterUsername == null ? null : twitterUsername,
    "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
    "bio": bio == null ? null : bio,
    "location": location == null ? null : location,
    "links": links.toJson(),
    "profile_image": profileImage.toJson(),
    "instagram_username": instagramUsername,
    "total_collections": totalCollections,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "accepted_tos": acceptedTos,
  };
}

class UserLinksRelated {
  UserLinksRelated({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  factory UserLinksRelated.fromJson(Map<String, dynamic> json) => UserLinksRelated(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    likes: json["likes"],
    portfolio: json["portfolio"],
    following: json["following"],
    followers: json["followers"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "likes": likes,
    "portfolio": portfolio,
    "following": following,
    "followers": followers,
  };
}

class ProfileImageRelated {
  ProfileImageRelated({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  String medium;
  String large;

  factory ProfileImageRelated.fromJson(Map<String, dynamic> json) => ProfileImageRelated(
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
