import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Photo extends StatelessWidget {
  final String photoLink;

  Photo({this.photoLink});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        imageUrl: photoLink,
      ),
    );
  }
}
