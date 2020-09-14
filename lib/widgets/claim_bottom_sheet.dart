import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/colors.dart';

class ClaimBottomSheet extends StatelessWidget {
  final List<String> complaints = ['adult', 'harm', 'bully', 'spam', 'copyright', 'hate'];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return ListTile(
            dense: true,
            title: Center(
              child: Text(complaints[index]),
            )
        );
      }
    );
  }
}
