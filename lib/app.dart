import 'dart:io';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(Connectivity().onConnectivityChanged),
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: Column(
                children: <Widget>[
                  Text('404'),
                  Text('Page not found'),
                ],
              ),
            ),
          );
        });
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments args =
              (settings.arguments as FullScreenImageArguments);
          final route = FullScreenImage(
            model: args.model,
            photo: args.photo,
            altDescription: args.altDescription,
            userName: args.userName,
            name: args.name,
            userPhoto: args.userPhoto,
            heroTag: args.heroTag,
          );

          if (Platform.isAndroid) {
            return MaterialPageRoute(
                builder: (context) => route, settings: args.settings);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(
                builder: (context) => route, settings: args.settings);
          }
        }
        ;
        if (settings.name == ProfileScreen.routeName) {
          ProfileScreenArguments args = (settings.arguments as ProfileScreenArguments);
          final route = ProfileScreen(
            username: args.username,
          );

          if (Platform.isAndroid) {
            return MaterialPageRoute(
                builder: (context) => route);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(
                builder: (context) => route);
          }
        }
      },
      theme: ThemeData(
        textTheme: AppStyles.buildAppTextTheme(),
      ),
    );
  }
}
