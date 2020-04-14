import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
//import 'package:trafficnow/API/credential.dart';
import 'package:trafficnow/widget/cupertinoSwitchListTile.dart';
import 'package:trafficnow/widget/myDialog.dart';
import 'package:trafficnow/module/userPlace.dart';
//import 'package:url_launcher/url_launcher.dart';

class MySwitchListTile extends StatefulWidget {
  MySwitchListTile({this.date, this.start, this.end, this.data});

  final UserPlace data;
  final DateTime date;
  final String start;
  final String end;

  @override
  _MySwitchListTileState createState() => _MySwitchListTileState();
}

class _MySwitchListTileState extends State<MySwitchListTile> {
//  _launchURL(start, dest) async {
//    final url =
//        'https://www.google.com/maps/dir/?api=$myKey&origin=${start}&destination=$dest';
//    print(url);
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw "Could not launch $url";
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitchListTile(
      value: widget.data.turnON,
      secondary: IconButton(
        icon: Icon(
          Icons.directions,
          size: 35.0,
        ),
        onPressed: () {
          //TODO: Google Map
//          try {
//            var start = widget.start.replaceAll(' ', '+').replaceAll(',', '');
//            var end = widget.end.replaceAll(' ', '+').replaceAll(',', '');
//            _launchURL(start, end);
//          } catch (e) {
//            print(e);
//          }
        },
      ),
      onChanged: (value) {
        setState(() {
          widget.data.turnON = value;
        });
        if (widget.data.turnON) {
          //TODO: Do Something when Switch is on
          //Below Dialog is only for test cases.
          closeButtonDialog(
              context: context,
              title: "Turned On!",
              content: "Your ${widget.start} is on!");
        }
      },
      activeColor: CupertinoColors.activeGreen,
      title: Text(
        DateFormat.jm().format(widget.date),
        style: TextStyle(fontSize: 25.0),
      ),
      subtitle: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Start: ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "${widget.start.split(',')[0]}\n",
              style: TextStyle(color: Colors.grey),
            ),
            TextSpan(
              text: "Dest: ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: widget.end.split(',')[0],
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
