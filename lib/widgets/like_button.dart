import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int likeCount;
  final bool isLiked;

  LikeButton({this.likeCount = 0, this.isLiked = false});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isLiked = !isLiked;
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
                widget.likeCount.toString(),
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
}
