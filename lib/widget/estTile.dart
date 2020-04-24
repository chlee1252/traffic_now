import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/service/estimateTime.dart';

class EstTile extends StatefulWidget {
  EstTile({this.userPlace});

  UserPlace userPlace;
  @override
  _EstTileState createState() => _EstTileState();
}

class _EstTileState extends State<EstTile> {
  DateTime now;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return widget.userPlace == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                    child: AutoSizeText(
                      "Estimate Arrival Time: ${DateFormat.jm().format(this.now)}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.userPlace.estTime,
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        final UserPlace result = await EstimateTime(
                          userData: widget.userPlace,
                        ).getEstimate();
                        setState(() {
                          this.now = DateTime.now();
                          widget.userPlace = result;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}