import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Photo extends StatelessWidget {
  String photo;

  Photo({this.photo, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl: photo != null ? photo : '',
            fit: BoxFit.fill,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
      ),
    );
  }
}
