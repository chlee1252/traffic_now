import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AlarmTile extends StatelessWidget {
  AlarmTile({this.value, this.date, this.start, this.dest, this.onChanged});

  final bool value;
  final DateTime date;
  final String start;
  final String dest;
  final ValueChanged<bool> onChanged;

  _launchURL() async {
    final url =
        'https://www.google.com/maps/dir/?api=1&origin=$start&destination=$dest';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.directions,
                size: 35.0,
                color: Colors.grey,
              ),
              onPressed: () {
                _launchURL();
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat.jm().format(this.date),
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(
            child: CupertinoSwitch(
              value: this.value,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
