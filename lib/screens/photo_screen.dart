import 'package:FlutterGalleryApp/models/photo.dart' as photoModel;
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/photo_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../widgets/widgets.dart';
import '../res/res.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.key,
    this.photo,
    this.altDescription,
    this.userName,
    this.name,
    this.userPhoto,
    this.heroTag,
    this.settings,
    this.model,
  });

  final Key key;
  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  final photoModel.ProfileImage userPhoto;
  final String heroTag;
  final RouteSettings settings;
  final photoModel.Photo model;
}

class FullScreenImage extends StatefulWidget {
  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  final String heroTag;
  final photoModel.ProfileImage userPhoto;
  final photoModel.Photo model;

  FullScreenImage({
    Key key,
    this.photo,
    this.altDescription,
    this.name,
    this.userName,
    this.heroTag,
    this.userPhoto,
    this.model,
  }) : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Download photos'),
          content: Text('Are you sure you want to download a photo?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Download'),
              onPressed: () {
                // GallerySaver.saveImage('path');
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Photo',
          style: TextStyle(color: AppColors.black),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: AppColors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert, color: AppColors.black),
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.mercury,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 300,
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                child: ClaimBottomSheet(),
                              ),
                            ]),
                      );
                    });
              })
        ],
      ),
      body: SingleChildScrollView(
              child: Column(children: <Widget>[
                // Hero(tag: widget.heroTag, child: Photo(photo: widget.photo)),
                Hero(tag: widget.heroTag, child: PhotoDetail(photo: widget.model)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: widget.altDescription != null
                      ? Description(description: widget.altDescription)
                      : Description(
                          description:
                              'Beautiful girl in a yellow dress with a flower on her head in the summer in the forest. Beautiful girl in a yellow dress with a flower on her head in the summer in the forest. Beautiful girl in a yellow dress with a flower on her head in the summer in the forest'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      StaggerAnimation(
                        controller: _controller.view,
                        userPhoto: widget.userPhoto,
                        name: widget.name,
                        userName: widget.userName,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      LikeButton(likeCount: 10, isLiked: true),
                      GestureDetector(
                          onTap: () {
                            print('*************** SAVE');
                            _showDialog();
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColors.dodgerBlue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'Save',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: AppColors.white),
                              ),
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            print('*************** VISIT');
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColors.dodgerBlue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'Visit',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: AppColors.white),
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ]),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class Name extends StatelessWidget {
  final String name;

  Name({this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class Username extends StatelessWidget {
  final String userName;

  Username({this.userName});

  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(color: AppColors.manatee),
    );
  }
}

class Description extends StatelessWidget {
  final String description;

  Description({this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: AppStyles.h3.copyWith(color: AppColors.manatee),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> opacityUsername;
  final photoModel.ProfileImage userPhoto;
  final String name;
  final String userName;

  StaggerAnimation({
    Key key,
    this.controller,
    this.userPhoto,
    this.name,
    this.userName,
  })  : opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        ),
        opacityUsername = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1.0, curve: Curves.ease),
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Row(children: <Widget>[
      Opacity(
        opacity: opacity.value,
        child: UserAvatar(userPhoto),
      ),
      SizedBox(
        width: 6,
      ),
      Opacity(
        opacity: opacityUsername.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Name(name: name == null ? 'unknow' : name),
            Username(userName: '@' + userName),
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
