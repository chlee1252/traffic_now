import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/service/location.dart';
import 'package:trafficnow/notification/notification.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';
import 'package:trafficnow/service/convertLatLong.dart';
import 'package:trafficnow/service/estimateTime.dart';
import 'package:trafficnow/storage/storage.dart';
import 'package:trafficnow/widget/alarmTile.dart';
import 'package:trafficnow/widget/destTile.dart';
import 'package:trafficnow/widget/emptyTile.dart';
import 'package:trafficnow/widget/estTile.dart';
import 'package:trafficnow/widget/infoCard.dart';
import 'package:trafficnow/widget/myBottomNav.dart';

//TODO: background Fetch
//TODO: Dynamic zoom by marker

class NewMainScreen extends StatefulWidget {
  static final String id = "NewMainScreen";
  final Location userLocation;

  NewMainScreen({this.userLocation});

  @override
  _NewMainScreenState createState() => _NewMainScreenState();
}

class _NewMainScreenState extends State<NewMainScreen> {
  UserPlace _userPlace;
  Storage storage = new Storage();
  LatLng position;
  int _currentIndex = 0;
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
    // Check if the storage has item. If it does, get it.
    storage.isReady().then((data) {
      setState(() {
        if (data) {
          _userPlace = storage.getItems();
          _addMarker(_userPlace);
          _addRoute(_userPlace);
        } else {
          _userPlace = null;
        }
      });
    });
    // Get Current User location.
    position = LatLng(widget.userLocation.lat, widget.userLocation.long);
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId("origin"),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure)));
    });
    requestIOS(plugin);
    initializeNotifications(plugin);
  }

  Future<LatLng> _getLatLng(UserPlace userPlace) async {
    ConvertLatLong data = ConvertLatLong(data: userPlace);
    LatLng result;
    try {
      result = await data.getLatLng();
    } catch (e) {
      result = null;
    }
    return result;
  }

  _addMarker(UserPlace result) async {
    var data = await _getLatLng(result);
    if (data != null) {
      if (_markers.length > 1) _markers.remove(_markers.last);

      setState(() {
        _markers.add(Marker(
            markerId: MarkerId(data.toString()),
            position: data,
            icon: BitmapDescriptor.defaultMarker));
      });
    }
  }

  _addRoute(UserPlace result) async {
    var routes =
        await EstimateTime(userData: result, userGeo: this.position)
        .getSteps();
    if (routes.length != 0) {
      setState(() {
        _polyline.clear();
        _polyline.add(Polyline(
          polylineId: PolylineId("direction"),
          visible: true,
          points: routes,
          width: 3,
          color: Colors.blue,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition _user = CameraPosition(
      target: position,
      zoom: 12.0,
      tilt: 0,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alarm),
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, PlaceInputScreen.id);
          if (result != null) {
            _addMarker(result);
            setState(() {
              _userPlace = result;
              storage.setItem(_userPlace);
            });
            _addRoute(result);

          }
        },
        backgroundColor: Color.fromRGBO(219, 235, 196, 1.0),
        foregroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _user,
                  markers: _markers,
                  polylines: _polyline,
                  trafficEnabled: true,
                  myLocationEnabled: true,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  InfoCard(
                    child: _userPlace == null
                        ? EmptyTile()
                        : DestTile(
                            dest: _userPlace.dest,
                          ),
                  ),
                  InfoCard(
                    child: _userPlace == null
                        ? EmptyTile()
                        : AlarmTile(
                            value: _userPlace.turnON,
                            date: _userPlace.date,
                            dest: _userPlace.formatURL(),
                            start: '${position.latitude},${position.longitude}',
                            onChanged: (value) {
                              setState(() {
                                if (value) {
                                  scheduleNotification(plugin, _userPlace, 0);
                                } else {
                                  plugin.cancel(0);
                                }
                                _userPlace.turnON = value;
                                storage.setItem(_userPlace);
                              });
                            },
                          ),
                  ),
                  InfoCard(
                    child: this._userPlace?.estTime == null
                        ? EmptyTile()
                        : EstTile(
                            userPlace: this._userPlace,
                            startGeo: position,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });
          if (index == 2 && _userPlace != null) {
            try {
              final UserPlace result = await EstimateTime(
                      userData: this._userPlace, userGeo: position)
                  .getEstimate();

              setState(() {
                this._userPlace = result;
              });
            } catch (e) {
              print(e);
            }
          }
        },
      ),
    );
  }
}
