import 'package:FlutterGalleryApp/dataprovider.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserFavoritePhotoList extends StatefulWidget {
  final String username;

  UserFavoritePhotoList({Key key, this.username}) : super(key: key);

  @override
  _UserFavoritePhotoListState createState() => _UserFavoritePhotoListState();
}

class _UserFavoritePhotoListState extends State<UserFavoritePhotoList>
    with AutomaticKeepAliveClientMixin {
  var photoList = List<UserFavoritePhotos>();
  ScrollController _scrollController = ScrollController();
  int page = 1;
  int perPage = 15;
  bool isLoading = false;

  @override
  void initState() {
    _getPhotos(widget.username, page, perPage);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        if (!isLoading) {
          print('page scroll: ' + page.toString());
          _getPhotos(widget.username, page, perPage);
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

  Future<Null> _getPhotos(String username, int page, int perPage) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var response =
          await DataProvider.getUserFavoritePhotos(widget.username, page, perPage);
      setState(() {
        photoList.addAll(response);
        this.page++;
        isLoading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildPhotoList(context, photoList);
  }

  Widget _buildPhotoList(BuildContext context, List<UserFavoritePhotos> photoList) {
    return photoList.length > 0
        ? StaggeredGridView.countBuilder(
            controller: _scrollController,
            crossAxisCount: 3,
            itemCount: photoList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == photoList.length) {
                return Center(
                  child: Opacity(
                    opacity: isLoading ? 1 : 0,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return CachedNetworkImage(imageUrl: photoList[index].coverPhoto.urls.small);
            },
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(1, index.isEven ? 1 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          )
        : Center(
            child: Text('Список фотографий пуст'),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
