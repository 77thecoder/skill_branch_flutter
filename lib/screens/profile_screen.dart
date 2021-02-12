import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ProfileScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
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
        body: Center(child: Text(widget.username)),
    );
  }
}
