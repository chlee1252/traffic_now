import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  InfoCard({this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      color: Colors.white,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: this.child,
    );
  }
}
