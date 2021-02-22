import 'package:FlutterGalleryApp/dataprovider.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/profile_slivers.dart';
import 'package:FlutterGalleryApp/widgets/profile_biography.dart';
import 'package:FlutterGalleryApp/widgets/user_main_photo_list.dart';
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

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  bool isLoadDataProfile = false;
  UserModel user;
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
      body: ProfileSlivers(username: args.username),
    );
  }
}
