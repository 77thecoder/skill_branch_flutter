import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/colors.dart';

class ClaimBottomSheet extends StatelessWidget {
  final List<String> complaints = ['ADULT', 'HARM', 'BULLY', 'SPAM', 'COPYRIGHT', 'HATE'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: ListTile(
            dense: true,
            title: Center(
              child: Text(complaints[index]),
            ),
          ),
            onTap: () {
              Navigator.pop(context);
            }
        );
      }
    );
  }
}
