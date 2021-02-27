import 'package:FlutterGalleryApp/dataprovider.dart';
import 'package:FlutterGalleryApp/models/photo.dart' as photoModel;
import 'package:FlutterGalleryApp/screens/profile_screen.dart';
import 'package:FlutterGalleryApp/utils/date_publication.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/photo_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
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

  bool isLoading = false;
  var data = List<photoModel.Photo>();

  @override
  void initState() {
    super.initState();

    _getRelatedPhotos();

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

  Future<Null> _getRelatedPhotos() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var response = await DataProvider.getRelatedPhotos(widget.model.id);
      setState(() {
        data.addAll(response.photos);
        isLoading = false;
      });
    }

    return null;
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
                _savePhoto(widget.model.id);
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

  Future<void> _showDialogSuccess() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Photo was successfully saved'),
          actions: <Widget>[
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

  Future<void> _showDialogError() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Error occurred while saving photo'),
          actions: <Widget>[
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

  Future<Null> _savePhoto(String id) async {
    String url = await DataProvider.getUrlDownload(id);

    try {
      await ImageDownloader.downloadImage(url);
    } catch (e) {
      _showDialogError();
      return null;
    }

    _showDialogSuccess();
  }

  Future<void> _visit(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
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
          _buildDatePublication(widget.model.createdAt),
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
                GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      ProfileScreen.routeName,
                      arguments:
                          ProfileScreenArguments(username: widget.userName),
                    )
                  },
                  child: StaggerAnimation(
                    controller: _controller.view,
                    userPhoto: widget.userPhoto,
                    name: widget.name,
                    userName: widget.userName,
                  ),
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
                    _visit(widget.model.links.html);
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
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 10, right: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (data.length > 0) _buildRelatedPhotoList(data),
              ],
            ),
          ),
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

class _buildDatePublication extends StatelessWidget {
  final DateTime createdAt;

  _buildDatePublication(this.createdAt);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          DatePublicaton.datePublicationToString(createdAt),
          style: AppStyles.h3.copyWith(color: AppColors.manatee),
        ),
      ),
    );
  }
}

class _buildRelatedPhotoList extends StatelessWidget {
  final List<photoModel.Photo> photoList;

  _buildRelatedPhotoList(this.photoList);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 3,
      itemCount: photoList.length,
      itemBuilder: (BuildContext context, int index) {
        return Hero(
          tag: photoList[index].id,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    '/fullScreenImage',
                    arguments: FullScreenImageArguments(
                        model: photoList[index],
                        photo: photoList[index].urls.small,
                        heroTag: photoList[index].id,
                        userPhoto: photoList[index].user.profileImage,
                        altDescription: photoList[index].altDescription,
                        name: photoList[index].user.name,
                        userName: photoList[index].user.username,
                    )
                );
              },
              child: CachedNetworkImage(imageUrl: photoList[index].urls.small)),
        );
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(1, index.isEven ? 1 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
