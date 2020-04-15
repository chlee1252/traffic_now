import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
//import 'package:trafficnow/API/credential.dart';
import 'package:trafficnow/widget/cupertinoSwitchListTile.dart';
import 'package:trafficnow/widget/myDialog.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/storage/storage.dart';
import 'package:trafficnow/module/scheduleList.dart';
//import 'package:url_launcher/url_launcher.dart';

class MySwitchListTile extends StatefulWidget {
  MySwitchListTile({this.data, this.index, this.storage, this.list});

  final UserPlace data;
  final int index;
  final Storage storage;
  final ScheduleList list;

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
        widget.list.scheduleList[widget.index] = widget.data;
        widget.storage.setItem(widget.list);
        if (widget.data.turnON) {
          //TODO: Do Something when Switch is on
          //Below Dialog is only for test cases.
          closeButtonDialog(
              context: context,
              title: "Turned On!",
              content: "Your ${widget.data.startPoint} is on!");
        }
      },
      activeColor: Color.fromRGBO(148, 119, 255, 1.0),
      title: Text(
        DateFormat.jm().format(widget.data.date),
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
              text: "${widget.data.startPoint.split(',')[0]}\n",
              style: TextStyle(color: Colors.grey),
            ),
            TextSpan(
              text: "Dest: ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: widget.data.dest.split(',')[0],
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
