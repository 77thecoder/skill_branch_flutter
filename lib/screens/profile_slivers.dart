import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileSlivers extends StatefulWidget {
  ProfileSlivers({Key key}) : super(key: key);

  @override
  _ProfileSliversState createState() => _ProfileSliversState();
}

class _ProfileSliversState extends State<ProfileSlivers> {
  @override
  Widget build(BuildContext context) {
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.white,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildProfileHeader(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                20,
                (int index) => new ListTile(title: new Text("Item $index")),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('ffdsff'),
          SizedBox(height: 40),
          Text('ffdsff'),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
