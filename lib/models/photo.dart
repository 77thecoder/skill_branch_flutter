// To parse this JSON data, do
//
//     final photo = photoFromJson(jsonString);

import 'dart:convert';

Photo photoFromJson(String str) => Photo.fromJson(json.decode(str));

String photoToJson(Photo data) => json.encode(data.toJson());

class Photo {
  Photo({
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
    // this.sponsorship,
    this.user,
    // this.exif,
    // this.location,
    // this.meta,
    // this.tags,
    // this.relatedCollections,
    // this.views,
    // this.downloads,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  dynamic description;
  String altDescription;
  Urls urls;
  PhotoLinks links;
  List<dynamic> categories;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  // Sponsorship sponsorship;
  User user;
  // Exif exif;
  // Location location;
  // Meta meta;
  // List<PhotoTag> tags;
  // RelatedCollections relatedCollections;
  // int views;
  // int downloads;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"],
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    description: json["description"],
    altDescription: json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
    links: PhotoLinks.fromJson(json["links"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    // sponsorship: json["sponsorship"] != null ? Sponsorship.fromJson(json["sponsorship"]) : null,
    user: User.fromJson(json["user"]),
    // exif: json["exif"] != null ? Exif.fromJson(json["exif"]) : null,
    // location: json["location"] != null ? Location.fromJson(json["location"]) : null,
    // meta: json["meta"] != null ? Meta.fromJson(json["meta"]) : null,
    // tags: json["tags"] != null ? List<PhotoTag>.from(json["tags"].map((x) => PhotoTag.fromJson(x))) : null,
    // relatedCollections: json["related_collections"] != null ? RelatedCollections.fromJson(json["related_collections"]) : null,
    // views: json["views"],
    // downloads: json["downloads"],
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
    "description": description,
    "alt_description": altDescription,
    "urls": urls.toJson(),
    "links": links.toJson(),
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "likes": likes,
    "liked_by_user": likedByUser,
    "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x)),
    // "sponsorship": sponsorship.toJson(),
    "user": user.toJson(),
    // "exif": exif.toJson(),
    // "location": location.toJson(),
    // "meta": meta.toJson(),
    // "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    // "related_collections": relatedCollections.toJson(),
    // "views": views,
    // "downloads": downloads,
  };
}

class Exif {
  Exif({
    this.make,
    this.model,
    this.exposureTime,
    this.aperture,
    this.focalLength,
    this.iso,
  });

  dynamic make;
  dynamic model;
  dynamic exposureTime;
  dynamic aperture;
  dynamic focalLength;
  dynamic iso;

  factory Exif.fromJson(Map<String, dynamic> json) => Exif(
    make: json["make"] != null ? json["make"] : null,
    model: json["model"],
    exposureTime: json["exposure_time"],
    aperture: json["aperture"],
    focalLength: json["focal_length"],
    iso: json["iso"],
  );

  Map<String, dynamic> toJson() => {
    "make": make,
    "model": model,
    "exposure_time": exposureTime,
    "aperture": aperture,
    "focal_length": focalLength,
    "iso": iso,
  };
}

class PhotoLinks {
  PhotoLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  String self;
  String html;
  String download;
  String downloadLocation;

  factory PhotoLinks.fromJson(Map<String, dynamic> json) => PhotoLinks(
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

class Location {
  Location({
    this.title,
    this.name,
    this.city,
    this.country,
    this.position,
  });

  dynamic title;
  dynamic name;
  dynamic city;
  dynamic country;
  Position position;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    title: json["title"],
    name: json["name"],
    city: json["city"],
    country: json["country"],
    position: Position.fromJson(json["position"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "name": name,
    "city": city,
    "country": country,
    "position": position.toJson(),
  };
}

class Position {
  Position({
    this.latitude,
    this.longitude,
  });

  dynamic latitude;
  dynamic longitude;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Meta {
  Meta({
    this.index,
  });

  bool index;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    index: json["index"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
  };
}

class RelatedCollections {
  RelatedCollections({
    this.total,
    this.type,
    this.results,
  });

  int total;
  String type;
  List<Result> results;

  factory RelatedCollections.fromJson(Map<String, dynamic> json) => RelatedCollections(
    total: json["total"],
    type: json["type"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "type": type,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.curated,
    this.featured,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.tags,
    this.links,
    this.user,
    this.coverPhoto,
    this.previewPhotos,
  });

  int id;
  String title;
  String description;
  DateTime publishedAt;
  DateTime lastCollectedAt;
  DateTime updatedAt;
  bool curated;
  bool featured;
  int totalPhotos;
  bool private;
  String shareKey;
  List<ResultTag> tags;
  ResultLinks links;
  User user;
  ResultCoverPhoto coverPhoto;
  List<PreviewPhoto> previewPhotos;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    description: json["description"] == null ? null : json["description"],
    publishedAt: DateTime.parse(json["published_at"]),
    lastCollectedAt: DateTime.parse(json["last_collected_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    curated: json["curated"],
    featured: json["featured"],
    totalPhotos: json["total_photos"],
    private: json["private"],
    shareKey: json["share_key"] == null ? null : json["share_key"],
    tags: List<ResultTag>.from(json["tags"].map((x) => ResultTag.fromJson(x))),
    links: ResultLinks.fromJson(json["links"]),
    user: User.fromJson(json["user"]),
    coverPhoto: ResultCoverPhoto.fromJson(json["cover_photo"]),
    previewPhotos: List<PreviewPhoto>.from(json["preview_photos"].map((x) => PreviewPhoto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description == null ? null : description,
    "published_at": publishedAt.toIso8601String(),
    "last_collected_at": lastCollectedAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "curated": curated,
    "featured": featured,
    "total_photos": totalPhotos,
    "private": private,
    "share_key": shareKey == null ? null : shareKey,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "links": links.toJson(),
    "user": user.toJson(),
    "cover_photo": coverPhoto.toJson(),
    "preview_photos": List<dynamic>.from(previewPhotos.map((x) => x.toJson())),
  };
}

class ResultCoverPhoto {
  ResultCoverPhoto({
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
  Urls urls;
  PhotoLinks links;
  List<dynamic> categories;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  User user;

  factory ResultCoverPhoto.fromJson(Map<String, dynamic> json) => ResultCoverPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"] == null ? null : DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"] == null ? null : json["blur_hash"],
    description: json["description"] == null ? null : json["description"],
    altDescription: json["alt_description"] == null ? null : json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
    links: PhotoLinks.fromJson(json["links"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    sponsorship: json["sponsorship"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "promoted_at": promotedAt == null ? null : promotedAt.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
    "blur_hash": blurHash == null ? null : blurHash,
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

class User {
  User({
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
  UserLinks links;
  ProfileImage profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    links: UserLinks.fromJson(json["links"]),
    profileImage: ProfileImage.fromJson(json["profile_image"]),
    instagramUsername: json["instagram_username"] == null ? null : json["instagram_username"],
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
    "instagram_username": instagramUsername == null ? null : instagramUsername,
    "total_collections": totalCollections,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "accepted_tos": acceptedTos,
  };
}

class UserLinks {
  UserLinks({
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

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
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

class ProfileImage {
  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  String medium;
  String large;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
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

class ResultLinks {
  ResultLinks({
    this.self,
    this.html,
    this.photos,
    this.related,
  });

  String self;
  String html;
  String photos;
  String related;

  factory ResultLinks.fromJson(Map<String, dynamic> json) => ResultLinks(
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

class PreviewPhoto {
  PreviewPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.urls,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  Urls urls;

  factory PreviewPhoto.fromJson(Map<String, dynamic> json) => PreviewPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    urls: Urls.fromJson(json["urls"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "urls": urls.toJson(),
  };
}

class ResultTag {
  ResultTag({
    this.type,
    this.title,
    this.source,
  });

  Type type;
  String title;
  PurpleSource source;

  factory ResultTag.fromJson(Map<String, dynamic> json) => ResultTag(
    type: typeValues.map[json["type"]],
    title: json["title"],
    source: json["source"] == null ? null : PurpleSource.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "title": title,
    "source": source == null ? null : source.toJson(),
  };
}

class PurpleSource {
  PurpleSource({
    this.ancestry,
    this.title,
    this.subtitle,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.coverPhoto,
  });

  Ancestry ancestry;
  String title;
  String subtitle;
  String description;
  String metaTitle;
  String metaDescription;
  PurpleCoverPhoto coverPhoto;

  factory PurpleSource.fromJson(Map<String, dynamic> json) => PurpleSource(
    ancestry: Ancestry.fromJson(json["ancestry"]),
    title: json["title"],
    subtitle: json["subtitle"],
    description: json["description"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    coverPhoto: PurpleCoverPhoto.fromJson(json["cover_photo"]),
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

class Ancestry {
  Ancestry({
    this.type,
    this.category,
    this.subcategory,
  });

  Category type;
  Category category;
  Category subcategory;

  factory Ancestry.fromJson(Map<String, dynamic> json) => Ancestry(
    type: Category.fromJson(json["type"]),
    category: Category.fromJson(json["category"]),
    subcategory: json["subcategory"] == null ? null : Category.fromJson(json["subcategory"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type.toJson(),
    "category": category.toJson(),
    "subcategory": subcategory == null ? null : subcategory.toJson(),
  };
}

class Category {
  Category({
    this.slug,
    this.prettySlug,
  });

  String slug;
  String prettySlug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    slug: json["slug"],
    prettySlug: json["pretty_slug"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "pretty_slug": prettySlug,
  };
}

class PurpleCoverPhoto {
  PurpleCoverPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
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
  String description;
  String altDescription;
  Urls urls;
  PhotoLinks links;
  List<dynamic> categories;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  User user;

  factory PurpleCoverPhoto.fromJson(Map<String, dynamic> json) => PurpleCoverPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"] == null ? null : DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    description: json["description"] == null ? null : json["description"],
    altDescription: json["alt_description"] == null ? null : json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
    links: PhotoLinks.fromJson(json["links"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    sponsorship: json["sponsorship"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "promoted_at": promotedAt == null ? null : promotedAt.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
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

enum Type { SEARCH, LANDING_PAGE }

final typeValues = EnumValues({
  "landing_page": Type.LANDING_PAGE,
  "search": Type.SEARCH
});

class Sponsorship {
  Sponsorship({
    this.impressionUrls,
    this.tagline,
    this.taglineUrl,
    this.sponsor,
  });

  List<String> impressionUrls;
  String tagline;
  String taglineUrl;
  User sponsor;

  factory Sponsorship.fromJson(Map<String, dynamic> json) => Sponsorship(
    impressionUrls: List<String>.from(json["impression_urls"].map((x) => x)),
    tagline: json["tagline"],
    taglineUrl: json["tagline_url"],
    sponsor: User.fromJson(json["sponsor"]),
  );

  Map<String, dynamic> toJson() => {
    "impression_urls": List<dynamic>.from(impressionUrls.map((x) => x)),
    "tagline": tagline,
    "tagline_url": taglineUrl,
    "sponsor": sponsor.toJson(),
  };
}

class PhotoTag {
  PhotoTag({
    this.type,
    this.title,
    this.source,
  });

  Type type;
  String title;
  FluffySource source;

  factory PhotoTag.fromJson(Map<String, dynamic> json) => PhotoTag(
    type: typeValues.map[json["type"]],
    title: json["title"],
    source: json["source"] == null ? null : FluffySource.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "title": title,
    "source": source == null ? null : source.toJson(),
  };
}

class FluffySource {
  FluffySource({
    this.ancestry,
    this.title,
    this.subtitle,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.coverPhoto,
  });

  Ancestry ancestry;
  String title;
  String subtitle;
  String description;
  String metaTitle;
  String metaDescription;
  ResultCoverPhoto coverPhoto;

  factory FluffySource.fromJson(Map<String, dynamic> json) => FluffySource(
    ancestry: Ancestry.fromJson(json["ancestry"]),
    title: json["title"],
    subtitle: json["subtitle"],
    description: json["description"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    coverPhoto: ResultCoverPhoto.fromJson(json["cover_photo"]),
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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
