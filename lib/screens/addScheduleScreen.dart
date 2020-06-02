import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trafficnow/providers/selectTime.dart';

class AddScheduleScreen extends StatelessWidget {
  static final String id = "AddScheduleScreen";

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color.fromRGBO(219, 235, 196, 1.0),
      appBar: AppBar(
        elevation: 0.0,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "Add New Schedule",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => SelectTime(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 3.0,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Consumer<SelectTime>(
                builder: (context, value, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: CupertinoDatePicker(
                          initialDateTime: value.getTime(),
                          mode: CupertinoDatePickerMode.time,
                          onDateTimeChanged: (datetime) {
                            Provider.of<SelectTime>(context, listen: false).setTime(datetime);
                          },
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        child: Center(
                          child: Text(
                            DateFormat.jm().format(value.getTime()),
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                              child: Text('Add',
                                  style: TextStyle(
                                      fontSize: 20.0, fontWeight: FontWeight.bold)),
                              textColor: Colors.black,
                              onPressed: () {
                                args['data'].date = value.getTime();
                                Navigator.pop(context, args['data']);
                              },
                            ),
                            Container(
                              width: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ), //This is Vertical Divider
                            FlatButton(
                              child: Text('Cancel',
                                  style: TextStyle(
                                      fontSize: 20.0, fontWeight: FontWeight.bold)),
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.pop(context, null);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
