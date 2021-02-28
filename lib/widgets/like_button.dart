import 'package:FlutterGalleryApp/dataprovider.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final Photo photo;

  LikeButton({this.photo, Key key}) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.photo.likedByUser;
    likeCount = widget.photo.likes;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          print('id ' + widget.photo.id);
          if (!isLiked) {
            print('like');
            _like(widget.photo.id);
            likeCount++;
            isLiked = true;
          } else if (isLiked) {
            print('unlike');
            _unlike(widget.photo.id);
            likeCount--;
            isLiked = false;
          }
        });
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
              SizedBox(width: 4.21,),
              Text(
                likeCount.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  height: 16 / 14
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

  Future<bool> _like(String id) async {
    return await DataProvider.like(id);
  }

  Future<bool> _unlike(String id) async {
    return await DataProvider.unlike(id);
  }
}
