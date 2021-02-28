import 'package:FlutterGalleryApp/dataprovider.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'screens.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _editingController = TextEditingController();
  var photoList = List<Photo>();
  int page = 1;
  int perPage = 15;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool loaded = false;
  String query;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        if (!isLoading) {
          print('page scroll: ' + page.toString());
          _searchPhotos(query, page, perPage);
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

  Future<Null> _searchPhotos(String query, int page, int perPage) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        loaded = false;
      });
      var response = await DataProvider.searchPhotos(query, page, perPage);
      setState(() {
        photoList.addAll(response.photos);
        this.page++;
        isLoading = false;
        loaded = true;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          photoList = List<Photo>();
          page = 1;
          await _searchPhotos(query, page, perPage);
          return null;
        },
        child: _page(),
      ),
    );
  }

  Widget _page() {
    return SafeArea(
      child: Column(
        children: [
          _buildSearchField(),
          if (photoList.length > 0) ...{
            Expanded(
              child: _buildPhotoList(context, photoList),
            ),
          },
          if (photoList.length == 0 &&
              loaded == true &&
              isLoading == false) ...{
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height - 100,
              child: Text('Nothing found'),
            ),
          },
          if (isLoading) ...{
            CircularProgressIndicator(),
          },
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          cursorColor: AppColors.manatee,
          style: TextStyle(
            color: AppColors.manatee,
          ),
          maxLines: 1,
          onChanged: (value) {},
          controller: _editingController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.manatee,
            ),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
              borderSide: BorderSide(
                color: AppColors.manatee,
              ),
            ),
            hintText: 'Search',
          ),
          onSubmitted: (String str) {
            print(str);
            setState(() {
              query = str;
              page = 1;
              photoList = List<Photo>();
            });
            _searchPhotos(query, page, perPage);
          },
        ),
      ),
    );
  }

  Widget _buildPhotoList(BuildContext context, List<Photo> photoList) {
    return StaggeredGridView.countBuilder(
      controller: _scrollController,
      crossAxisCount: 2,
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
        return _buildItemPhoto(photoList[index]);
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(1, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  Widget _buildItemPhoto(Photo photo) {
    return GestureDetector(
      onTap: () {
        _getPhoto(photo.id);
      },
      child: Hero(
        tag: photo.id,
        child: CachedNetworkImage(
          imageUrl: photo.urls.small,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> _getPhoto(String id) async {
    Photo photo = await DataProvider.getPhoto(id);
    Navigator.pushNamed(context, '/fullScreenImage',
        arguments: FullScreenImageArguments(
          model: photo,
          photo: photo.urls.small,
          heroTag: photo.id + photo.user.username,
          userPhoto: photo.user.profileImage,
          altDescription: photo.altDescription,
          name: photo.user.name,
          userName: photo.user.username,
        ));
  }
}
