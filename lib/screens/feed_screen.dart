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
  int page = 1;
  var data = List<photoModel.Photo>();
  bool isLoading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _getPhotos(page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        if (!isLoading) {
          print('page scroll: ' + page.toString());
          _getPhotos(page);
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPhotoList(context, data),
      // resizeToAvoidBottomPadding: false,
    );
  }

  Future<Null> _getPhotos(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var response = await DataProvider.getPhotos(page, 10);

      setState(() {
        data.addAll(response.photos);
        this.page++;
        isLoading = false;
      });
    }

    return null;
  }

  Widget _buildPhotoList(BuildContext context, List<photoModel.Photo> photos) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height - 80,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: photos.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == data.length) {
                return Center(
                  child: Opacity(
                    opacity: isLoading ? 1 : 0,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: _buildItemPhoto(photo: photos[index])
                    ),
                    // Divider(thickness: 2, color: AppColors.mercury,),
                  ],
                ),
              );
            },
          ),
          onRefresh: () async {
            data = List<photoModel.Photo>();
            page = 1;
            await _getPhotos(page);
            return null;
          },
        ),
      ),
    );
  }
}

class _buildItemPhoto extends StatelessWidget {
  photoModel.Photo photo;

  _buildItemPhoto({this.photo});

  @override
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
                  photo: photo.urls.small,
                  heroTag: photo.id,
                  userPhoto: photo.user.profileImage,
                  altDescription: 'This is Flutter dash. I love him :)',
                  name: photo.user.name,
                  userName: photo.user.username,
                  settings: RouteSettings(arguments: kFlutterDash)
              )
            );
          },
          child: Hero(
            tag: photo.id,
            child: Photo(photo: photo.urls.small),
          ),
        ),
        _buildPhotoMeta(photo: photo),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //   child: Text(
        //     photo.altDescription,
        //     maxLines: 3,
        //     overflow: TextOverflow.ellipsis,
        //     style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.manatee),
        //   ),
        // ),
      ],
    );
  }
}

class _buildPhotoMeta extends StatelessWidget {
  photoModel.Photo photo;

  _buildPhotoMeta({this.photo});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(photo.user.profileImage),
              SizedBox(width: 6,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(photo.user.name, style: Theme.of(context).textTheme.subtitle1,),
                  Text('@' + photo.user.username, style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.manatee),),
                ],
              )
            ],
          ),
          LikeButton(likeCount: photo.likes, isLiked: photo.likedByUser)
        ],
      ),
    );
  }
}