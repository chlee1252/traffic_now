import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DestTile extends StatelessWidget {
  DestTile({this.dest});

  final String dest;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.location_on,
                size: 35.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: AutoSizeText(
              this.dest,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
