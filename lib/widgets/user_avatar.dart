import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserAvatar extends StatelessWidget {
  final String avatarLink;

  UserAvatar(this.avatarLink);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CachedNetworkImage(
        width: 40,
        height: 40,
        imageUrl: avatarLink,
        fit: BoxFit.fill,
      ),
    );
  }
}
