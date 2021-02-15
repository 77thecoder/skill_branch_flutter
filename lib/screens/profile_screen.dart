import 'package:FlutterGalleryApp/dataprovider.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreenArguments {
  final String username;

  ProfileScreenArguments({this.username});
}

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  final String username;

  ProfileScreen({this.username});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  bool isLoadDataProfile = false;
  UserModel user;
  TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
    _getProfile(widget.username);
  }

  void _handleTabSelection() {
    setState(() {
    });
  }

  Future<UserModel> _getProfile(String username) async {
    if (!isLoadDataProfile) {
      setState(() {
        isLoadDataProfile = true;
      });
    }

    user = await DataProvider.user(username);

    setState(() {
      isLoadDataProfile = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProfileScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Text(
            'Profile',
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
        ),
        body: isLoadDataProfile
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _buildProfile());
  }

  Widget _buildProfile() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 40),
            _buildProfileTabs(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(33),
                  child: CachedNetworkImage(
                    imageUrl: user.profileImage.medium,
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
                user.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user.followersCount.toString(),
                    style: AppStyles.counter,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 10),
                  Text('followers'),
                  SizedBox(width: 26),
                  Text(
                    user.followingCount.toString(),
                    style: AppStyles.counter,
                  ),
                  SizedBox(width: 10),
                  Text('following'),
                ],
              ),
              if (user.location != null) ...{
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.dodgerBlue,
                    ),
                    SizedBox(width: 10),
                    Text(user.location),
                  ],
                ),
              },
              if (user.portfolioUrl != null) ...{
                SizedBox(height: 10),
                Row(
                  children: [
                    _buildIconUrl(),
                    SizedBox(width: 10),
                    if (user.portfolioUrl != null)
                      Text(
                        user.portfolioUrl.replaceAll(
                            new RegExp('^http:\/\/|https:\/\/'), ''),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              },
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

  Widget _buildProfileTabs() {
    return DefaultTabController(
      length: 3,
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.dodgerBlue,
        tabs: [
          Tab(
            icon: SvgPicture.asset(
              'assets/svg/profile_tab_home.svg',
              color: _tabController.index == 0 ? AppColors.dodgerBlue : AppColors.black,
              fit: BoxFit.contain,
            ),
          ),
          Tab(
            icon: SvgPicture.asset(
              'assets/svg/profile_tab_like.svg',
              color: _tabController.index == 1 ? AppColors.dodgerBlue : AppColors.black,
              fit: BoxFit.contain,
            ),
          ),
          Tab(
            icon: SvgPicture.asset(
              'assets/svg/profile_tab_favorites.svg',
              color: _tabController.index == 2 ? AppColors.dodgerBlue : AppColors.black,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
