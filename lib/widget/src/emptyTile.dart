import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EmptyTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: AutoSizeText(
          "Please add Destination :)",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      ),
    );
  }
}
