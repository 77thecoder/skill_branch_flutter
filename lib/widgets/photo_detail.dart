import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FlutterGalleryApp/models/photo.dart' as photoModel;

class PhotoDetail extends StatelessWidget {
  final photoModel.Photo photo;

  PhotoDetail({this.photo, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthContainer = MediaQuery.of(context).size.width;
    final int widthImage = photo.width;
    final int heightImage = photo.height;
    final double heightContainer = (widthContainer / widthImage) * heightImage;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: CachedNetworkImage(
          imageUrl: photo.urls.small != null ? photo.urls.small : '',
          width: widthContainer,
          height: heightContainer,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: const CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
