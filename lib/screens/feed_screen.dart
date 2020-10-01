import 'dart:convert';

import 'package:FlutterGalleryApp/dataprovider.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/models/photo.dart' as photoModel;

const String kFlutterDash = 'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';
const String userPhoto = 'https://skill-branch.ru/img/speakers/Adechenko.jpg';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int page = 0;
  var data = List<photoModel.Photo>();
  bool isLoading = false;

  @override
  void initState() {
    _getPhotos(page);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              _buildItem(index: index, heroTag: 'img-' + index.toString(),),
              Divider(thickness: 2, color: AppColors.mercury,),
            ],
          );
        },
      ) : Center(child: CircularProgressIndicator()),
    );
  }

  void _getPhotos(int page) async {
    var response = await DataProvider.getPhotos(page, 10);
    print('response');

    setState(() {
      data.addAll(response.photos);
      page++;
      isLoading = true;
    });
  }
}

class _buildItem extends StatelessWidget {
  String heroTag;
  int index;

  _buildItem({this.heroTag, this.index});

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/fullScreenImage',
              arguments: FullScreenImageArguments(
                photo: kFlutterDash,
                heroTag: this.heroTag,
                userPhoto: userPhoto,
                altDescription: 'This is Flutter dash. I love him :)',
                name: 'Kirill Adeshchenko',
                userName: '@kaparray',
                settings: RouteSettings(arguments: kFlutterDash)
              )
            );
          },
          child: Hero(
            tag: heroTag,
            child: Photo(photo: kFlutterDash),
          ),
        ),
        _buildPhotoMeta(index: index),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            'This is Flutter dash. I love him :)',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.manatee),
          ),
        ),
      ],
    );
  }
}

class _buildPhotoMeta extends StatelessWidget {
  int index;

  _buildPhotoMeta({this.index});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(userPhoto),
              SizedBox(width: 6,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Kirill Adeshchenko', style: Theme.of(context).textTheme.headline6,),
                  Text('@kaparray', style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.manatee),),
                ],
              )
            ],
          ),
          LikeButton(likeCount: 10, isLiked: true)
        ],
      ),
    );
  }
}