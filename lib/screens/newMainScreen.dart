import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trafficnow/module/userPlace.dart';
import 'package:trafficnow/service/location.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';
import 'package:trafficnow/service/convertLatLong.dart';
import 'package:trafficnow/service/estimateTime.dart';
import 'package:trafficnow/widget/alarmTile.dart';
import 'package:trafficnow/widget/destTile.dart';
import 'package:trafficnow/widget/emptyTile.dart';
import 'package:trafficnow/widget/estTile.dart';
import 'package:trafficnow/widget/infoCard.dart';
import 'package:trafficnow/widget/myBottomNav.dart';

//TODO: Google Map draw direction by road
//TODO: localStorage refactor
//TODO: background Fetch

class NewMainScreen extends StatefulWidget {
  static final String id = "NewMainScreen";
  final Location userLocation;

  NewMainScreen({this.userLocation});

  @override
  _NewMainScreenState createState() => _NewMainScreenState();
}

class _NewMainScreenState extends State<NewMainScreen> {
  UserPlace _userPlace;
  LatLng position;
  int _currentIndex = 0;
  Set<Marker> _markers = {};
  List<LatLng> latlng = List();
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    position = LatLng(widget.userLocation.lat, widget.userLocation.long);
    setState(() {
      this.latlng.add(position);
      _markers.add(Marker(
          markerId: MarkerId("origin"),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure)));
    });
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

  @override
  Widget build(BuildContext context) {
    final CameraPosition _user = CameraPosition(
      target: position,
      zoom: 14.0,
      tilt: 0,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alarm),
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, PlaceInputScreen.id);
          if (result != null) {
            var data = await _getLatLng(result);
            if (data != null) {
              if (_markers.length > 1) _markers.remove(_markers.last);
              if (latlng.length > 1) latlng.removeLast();
              if (_polylines.length > 0) _polylines.remove(_polylines.last);

              setState(() {
                latlng.add(data);
                _userPlace = result;
                _markers.add(Marker(
                    markerId: MarkerId(data.toString()),
                    position: data,
                    icon: BitmapDescriptor.defaultMarker));
                _polylines.add(Polyline(
                  polylineId: PolylineId(position.toString()),
                  visible: true,
                  points: latlng,
                  color: Colors.blue,
                  width: 5,
                ));
              });
            } else {
              setState(() {
                _userPlace = result;
              });
            }
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
                  polylines: _polylines,
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
                                _userPlace.turnON = value;
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
//          print(args['userLocation'].lat);
//          print(args['userLocation'].long);
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
