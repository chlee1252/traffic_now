import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:trafficnow/widget/cupertinoSwitchListTile.dart';

class MySwitchListTile extends StatefulWidget {
  MySwitchListTile({this.title});

  final DateTime title;

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
      },
      activeColor: CupertinoColors.activeGreen,
      title: Text(
        DateFormat.jm().format(widget.title),
        style: TextStyle(fontSize: 25.0),
      ),
    );
  }
}
