import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:trafficnow/module/userPlace.dart';

class AddScheduleScreen extends StatefulWidget {

  static final String id = "AddScheduleScreen";

  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  DateTime date;

  @override
  void initState() {
    super.initState();
    this.date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "Add New Schedule",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 3.0,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: CupertinoDatePicker(
                  initialDateTime: date,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (datetime) {
                    setState(() {
                      date = datetime;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Center(
                child: Text(DateFormat.jm().format(date)),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text('Add', style: TextStyle(fontSize: 20.0)),
                    textColor: Colors.blueAccent,
                    onPressed: () {
                      args['data'].date = this.date;
                      Navigator.pop(context, args['data']);
                    },
                  ),
                  Container(
                    width: 1.0,
                    height: 30.0,
                    color: Colors.grey,
                  ), //This is Vertical Divider
                  FlatButton(
                    child: Text('Cancel', style: TextStyle(fontSize: 20.0)),
                    textColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
