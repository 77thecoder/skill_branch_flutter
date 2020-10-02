import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FlutterGalleryApp/models/models.dart';

class UserAvatar extends StatelessWidget {
  final ProfileImage avatarLink;

  UserAvatar(this.avatarLink);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CachedNetworkImage(
        width: 40,
        height: 40,
        imageUrl: avatarLink.small,
        fit: BoxFit.fill,
      ),
    );
  }
}
