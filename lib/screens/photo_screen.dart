import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/widgets.dart';
import '../res/res.dart';

class FullScreenImage extends StatefulWidget {
  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  final String heroTag;
  final String userPhoto;

  FullScreenImage({
    Key key,
    this.photo,
    this.altDescription,
    this.name,
    this.userName,
    this.heroTag,
    this.userPhoto
  }) : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Photo', style: TextStyle(color: AppColors.black),),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(CupertinoIcons.back, color: AppColors.black,),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Center(
        child:
          Column(
            children: <Widget>[
              Hero(
                tag: widget.heroTag,
                child: Photo(photo: widget.photo)
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: widget.altDescription != null ? Description(description: widget.altDescription) : Description(description: 'Beautiful girl in a yellow dress with a flower on her head in the summer in the forest. Beautiful girl in a yellow dress with a flower on her head in the summer in the forest. Beautiful girl in a yellow dress with a flower on her head in the summer in the forest'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    StaggerAnimation(
                      controller: _controller.view,
                      userPhoto: widget.userPhoto,
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
                      },
                      child:
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.dodgerBlue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child:
                              Text(
                                'Save',
                                style: AppStyles.h2Black.copyWith(color: AppColors.white),
                              ),
                          ),
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                          print('*************** VISIT');
                        },
                        child:
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.dodgerBlue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child:
                            Text(
                              'Visit',
                              style: AppStyles.h2Black.copyWith(color: AppColors.white),
                            ),
                          ),
                        )
                    )
                  ],
                ),
              )
            ]
          ),
        ),
      );
  }
}

class Name extends StatelessWidget {
  final String name;

  Name({this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name, style: AppStyles.h1Black,);
  }
}

class Username extends StatelessWidget {
  final String userName;

  Username({this.userName});

  @override
  Widget build(BuildContext context) {
    return Text(userName, style: AppStyles.h5Black.copyWith(color: AppColors.manatee),);
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
  final String userPhoto;

  StaggerAnimation({Key key, this.controller, this.userPhoto}) :
    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.5,
          curve: Curves.ease
        ),
      ),
    ),

    opacityUsername = Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.5, 1.0,
          curve: Curves.ease
        ),
      ),
    ),

    super(key: key);

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Row(
      children: <Widget>[
        Opacity(
          opacity: opacity.value,
          child: UserAvatar(userPhoto)
        ),
        SizedBox(width: 6,),
        Opacity(
          opacity: opacityUsername.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Name(name: 'Kirill Adeshchenko'),
              Username(userName: '@kaparray'),
            ],
          ),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
