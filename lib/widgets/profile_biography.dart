import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class Biography extends StatelessWidget {
  final String biography;

  Biography({this.biography});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      biography,
      trimLines: 3,
      colorClickableText: AppColors.dodgerBlue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'view more',
      trimExpandedText: 'close',
      moreStyle: TextStyle(
        fontWeight: FontWeight.bold,
        // color: AppColors.dodgerBlue,
      ),
    );
  }
}
