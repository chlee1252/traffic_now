import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AlarmTile extends StatelessWidget {
  AlarmTile({this.value, this.date, this.onChanged});

  final bool value;
  final DateTime date;
  final ValueChanged<bool> onChanged;

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
                print("Hello");
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
