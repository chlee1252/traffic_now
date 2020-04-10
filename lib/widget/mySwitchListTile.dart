import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:trafficnow/widget/cupertinoSwitchListTile.dart';

class MySwitchListTile extends StatefulWidget {
  MySwitchListTile({this.date, this.start, this.end});

  final DateTime date;
  final String start;
  final String end;

  @override
  _MySwitchListTileState createState() => _MySwitchListTileState();
}

class _MySwitchListTileState extends State<MySwitchListTile> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitchListTile(
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
        if (_value) {
          //TODO: Do Something when Switch is on
          //Below Dialog is only for test cases.
          showDialog(
            context: context,
            builder: (BuildContext context) => new CupertinoAlertDialog(
              title: Text("Turned On!"),
              content: Text("Your ${widget.start} is on!"),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
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
              text: "${widget.start}\n",
              style: TextStyle(color: Colors.grey),
            ),
            TextSpan(
              text: "Dest: ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: widget.end,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
