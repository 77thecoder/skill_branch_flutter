import 'package:FlutterGalleryApp/dataprovider.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/styles.dart';
import 'package:FlutterGalleryApp/widgets/profile_biography.dart';
import 'package:FlutterGalleryApp/widgets/user_main_photo_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileSlivers extends StatefulWidget {
  final String username;

  ProfileSlivers({Key key, this.username}) : super(key: key);

  @override
  _ProfileSliversState createState() => _ProfileSliversState();
}

class _ProfileSliversState extends State<ProfileSlivers>
    with TickerProviderStateMixin {
  bool isLoadDataProfile = false;
  UserModel userModel;
  TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
    _getProfile(widget.username);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  Future<void> _getProfile(String username) async {
    if (!isLoadDataProfile) {
      setState(() {
        isLoadDataProfile = true;
      });
    }

    userModel = await DataProvider.user(username);

    setState(() {
      isLoadDataProfile = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _page(),
    );
  }

  Widget _page() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
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
          title: Text(
            'Profile',
            style: TextStyle(color: AppColors.black),
          ),
          centerTitle: true,
          backgroundColor: AppColors.white,
          expandedHeight: 185,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildProfileHeader(),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              if (userModel.bio != null) ...{
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 8, top: 10, right: 8, bottom: 10),
                        alignment: Alignment.topLeft,
                        child: _buildProfileBiography(),
                      ),
                    ),
                  ],
                ),
              },
            ],
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: StickyTabBarDelegate(
            child: _buildTabs(),
          ),
        ),
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                UserMainPhotoList(
                    key: PageStorageKey('mainPhotoList'),
                    username: userModel.username),
                // Text('Likes'),
                UserMainPhotoList(
                    key: PageStorageKey('likePhotoList'),
                    username: userModel.username),
                UserMainPhotoList(
                    key: PageStorageKey('favoritePhotoList'),
                    username: userModel.username),
                // Text('Favorites'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 90, right: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(33),
                      child: CachedNetworkImage(
                        imageUrl: userModel.profileImage.medium,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userModel.followersCount.toString(),
                        style: AppStyles.counter,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 10),
                      Text('followers'),
                      SizedBox(width: 26),
                      Text(
                        userModel.followingCount.toString(),
                        style: AppStyles.counter,
                      ),
                      SizedBox(width: 10),
                      Text('following'),
                    ],
                  ),
                  if (userModel.location != null) ...{
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppColors.dodgerBlue,
                        ),
                        SizedBox(width: 10),
                        Text(userModel.location),
                      ],
                    ),
                  },
                  if (userModel.portfolioUrl != null) ...{
                    SizedBox(height: 10),
                    Row(
                      children: [
                        _buildIconUrl(),
                        SizedBox(width: 10),
                        Text(
                          userModel.portfolioUrl.replaceFirst(
                              RegExp('^http:\/\/|https:\/\/'), ''),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  },
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconUrl() {
    return Stack(children: <Widget>[
      Container(
        width: 15,
        height: 15,
      ),
      Positioned(
        left: 4.5,
        child: SvgPicture.asset(
          'assets/svg/url_top.svg',
          height: 10,
          width: 10,
          color: AppColors.dodgerBlue,
          fit: BoxFit.contain,
        ),
      ),
      Positioned(
        top: 5,
        left: 2,
        child: SvgPicture.asset(
          'assets/svg/url_bottom.svg',
          height: 10,
          width: 10,
          color: AppColors.dodgerBlue,
          fit: BoxFit.contain,
        ),
      ),
    ]);
  }

  Widget _buildProfileBiography() {
    return Biography(
      biography: userModel.bio,
    );
  }

  Widget _buildTabs() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.dodgerBlue,
      unselectedLabelColor: Colors.black,
      indicatorColor: AppColors.dodgerBlue,
      tabs: [
        Tab(
          icon: Icon(
            Icons.home_outlined,
          ),
          // child: Container(),
          iconMargin: EdgeInsets.only(bottom: 0.1),
        ),
        Tab(
          icon: Icon(
            Icons.favorite_border_outlined,
          ),
          // child: Container(),
          iconMargin: EdgeInsets.only(bottom: 0.1),
        ),
        Tab(
          icon: Icon(
            Icons.bookmark_outline_outlined,
          ),
          // child: Container(),
          iconMargin: EdgeInsets.only(bottom: 0.1),
        ),
      ],
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white),
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
