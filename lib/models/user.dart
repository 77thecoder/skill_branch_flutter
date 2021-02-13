import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
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
    this.followedByUser,
    this.photos,
    this.badge,
    this.tags,
    this.followersCount,
    this.followingCount,
    this.allowMessages,
    this.forHire,
    this.numericId,
    this.downloads,
    this.meta,
  });

  String id;
  DateTime updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  dynamic twitterUsername;
  String portfolioUrl;
  String bio;
  String location;
  UserLinksModel links;
  UserProfileImage profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;
  bool followedByUser;
  List<UserPhoto> photos;
  dynamic badge;
  Tags tags;
  int followersCount;
  int followingCount;
  bool allowMessages;
  bool forHire;
  int numericId;
  int downloads;
  UserMeta meta;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["username"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    twitterUsername: json["twitter_username"],
    portfolioUrl: json["portfolio_url"],
    bio: json["bio"],
    location: json["location"],
    links: UserLinksModel.fromJson(json["links"]),
    profileImage: UserProfileImage.fromJson(json["profile_image"]),
    instagramUsername: json["instagram_username"],
    totalCollections: json["total_collections"],
    totalLikes: json["total_likes"],
    totalPhotos: json["total_photos"],
    acceptedTos: json["accepted_tos"],
    followedByUser: json["followed_by_user"],
    photos: List<UserPhoto>.from(json["photos"].map((x) => UserPhoto.fromJson(x))),
    badge: json["badge"],
    tags: Tags.fromJson(json["tags"]),
    followersCount: json["followers_count"],
    followingCount: json["following_count"],
    allowMessages: json["allow_messages"],
    forHire: json["for_hire"],
    numericId: json["numeric_id"],
    downloads: json["downloads"],
    meta: UserMeta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
    "username": username,
    "name": name,
    "first_name": firstName,
    "last_name": lastName,
    "twitter_username": twitterUsername,
    "portfolio_url": portfolioUrl,
    "bio": bio,
    "location": location,
    "links": links.toJson(),
    "profile_image": profileImage.toJson(),
    "instagram_username": instagramUsername,
    "total_collections": totalCollections,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "accepted_tos": acceptedTos,
    "followed_by_user": followedByUser,
    "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    "badge": badge,
    "tags": tags.toJson(),
    "followers_count": followersCount,
    "following_count": followingCount,
    "allow_messages": allowMessages,
    "for_hire": forHire,
    "numeric_id": numericId,
    "downloads": downloads,
    "meta": meta.toJson(),
  };
}

class UserLinksModel {
  UserLinksModel({
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

  factory UserLinksModel.fromJson(Map<String, dynamic> json) => UserLinksModel(
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

class UserMeta {
  UserMeta({
    this.index,
  });

  bool index;

  factory UserMeta.fromJson(Map<String, dynamic> json) => UserMeta(
    index: json["index"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
  };
}

class UserPhoto {
  UserPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.blurHash,
    this.urls,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String blurHash;
  UserUrls urls;

  factory UserPhoto.fromJson(Map<String, dynamic> json) => UserPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    blurHash: json["blur_hash"],
    urls: UserUrls.fromJson(json["urls"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "blur_hash": blurHash,
    "urls": urls.toJson(),
  };
}

class UserUrls {
  UserUrls({
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

  factory UserUrls.fromJson(Map<String, dynamic> json) => UserUrls(
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

class UserProfileImage {
  UserProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  String medium;
  String large;

  factory UserProfileImage.fromJson(Map<String, dynamic> json) => UserProfileImage(
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

class Tags {
  Tags({
    this.custom,
    this.aggregated,
  });

  List<Custom> custom;
  List<Aggregated> aggregated;

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
    custom: List<Custom>.from(json["custom"].map((x) => Custom.fromJson(x))),
    aggregated: List<Aggregated>.from(json["aggregated"].map((x) => Aggregated.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "custom": List<dynamic>.from(custom.map((x) => x.toJson())),
    "aggregated": List<dynamic>.from(aggregated.map((x) => x.toJson())),
  };
}

class Aggregated {
  Aggregated({
    this.type,
    this.title,
    this.source,
  });

  UserType type;
  String title;
  Source source;

  factory Aggregated.fromJson(Map<String, dynamic> json) => Aggregated(
    type: userTypeValues.map[json["type"]],
    title: json["title"],
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "type": userTypeValues.reverse[type],
    "title": title,
    "source": source == null ? null : source.toJson(),
  };
}

class Source {
  Source({
    this.ancestry,
    this.title,
    this.subtitle,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.coverPhoto,
  });

  UserAncestry ancestry;
  String title;
  String subtitle;
  String description;
  String metaTitle;
  String metaDescription;
  CoverPhoto coverPhoto;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    ancestry: UserAncestry.fromJson(json["ancestry"]),
    title: json["title"],
    subtitle: json["subtitle"],
    description: json["description"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    coverPhoto: CoverPhoto.fromJson(json["cover_photo"]),
  );

  Map<String, dynamic> toJson() => {
    "ancestry": ancestry.toJson(),
    "title": title,
    "subtitle": subtitle,
    "description": description,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "cover_photo": coverPhoto.toJson(),
  };
}

class UserAncestry {
  UserAncestry({
    this.type,
    this.category,
    this.subcategory,
  });

  UserCategory type;
  UserCategory category;
  UserCategory subcategory;

  factory UserAncestry.fromJson(Map<String, dynamic> json) => UserAncestry(
    type: UserCategory.fromJson(json["type"]),
    category: UserCategory.fromJson(json["category"]),
    subcategory: UserCategory.fromJson(json["subcategory"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type.toJson(),
    "category": category.toJson(),
    "subcategory": subcategory.toJson(),
  };
}

class UserCategory {
  UserCategory({
    this.slug,
    this.prettySlug,
  });

  String slug;
  String prettySlug;

  factory UserCategory.fromJson(Map<String, dynamic> json) => UserCategory(
    slug: json == null ? '' : json["slug"],
    prettySlug: json == null ? '' : json["pretty_slug"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "pretty_slug": prettySlug,
  };
}

class CoverPhoto {
  CoverPhoto({
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
  dynamic promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  String description;
  String altDescription;
  UserUrls urls;
  CoverPhotoLinks links;
  List<dynamic> categories;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  UserClass user;

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => CoverPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"],
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    description: json["description"] == null ? null : json["description"],
    altDescription: json["alt_description"] == null ? null : json["alt_description"],
    urls: UserUrls.fromJson(json["urls"]),
    links: CoverPhotoLinks.fromJson(json["links"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    sponsorship: json["sponsorship"],
    user: UserClass.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "promoted_at": promotedAt,
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

class CoverPhotoLinks {
  CoverPhotoLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  String self;
  String html;
  String download;
  String downloadLocation;

  factory CoverPhotoLinks.fromJson(Map<String, dynamic> json) => CoverPhotoLinks(
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

class UserClass {
  UserClass({
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
  UserLinksModel links;
  UserProfileImage profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["username"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    twitterUsername: json["twitter_username"],
    portfolioUrl: json["portfolio_url"],
    bio: json["bio"] == null ? null : json["bio"],
    location: json["location"],
    links: UserLinksModel.fromJson(json["links"]),
    profileImage: UserProfileImage.fromJson(json["profile_image"]),
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
    "last_name": lastName,
    "twitter_username": twitterUsername,
    "portfolio_url": portfolioUrl,
    "bio": bio == null ? null : bio,
    "location": location,
    "links": links.toJson(),
    "profile_image": profileImage.toJson(),
    "instagram_username": instagramUsername,
    "total_collections": totalCollections,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "accepted_tos": acceptedTos,
  };
}

enum UserType { SEARCH, LANDING_PAGE }

final userTypeValues = UserEnumValues({
  "landing_page": UserType.LANDING_PAGE,
  "search": UserType.SEARCH
});

class Custom {
  Custom({
    this.type,
    this.title,
  });

  UserType type;
  String title;

  factory Custom.fromJson(Map<String, dynamic> json) => Custom(
    type: userTypeValues.map[json["type"]],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "type": userTypeValues.reverse[type],
    "title": title,
  };
}

class UserEnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  UserEnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
