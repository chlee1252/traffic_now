import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trafficnow/notification/notification.dart';
import 'package:trafficnow/providers/mainProviderExport.dart';
import 'package:trafficnow/screens/placeInputScreen.dart';
import 'package:trafficnow/service/estimateTime.dart';
import 'package:trafficnow/storage/storage.dart';
import 'package:trafficnow/widget/mainScreenWidgets.dart';

//TODO: Dynamic zoom by marker (Additional Feature)

class MainScreen extends StatefulWidget {
  static final String id = "MainScreen";
  final LatLng position;

  MainScreen({this.position});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Storage storage = new Storage();
  int _currentIndex = 0;
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestIOS(plugin);
    initializeNotifications(plugin);
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition _user = CameraPosition(
      target: widget.position,
      zoom: 12.0,
      tilt: 0,
    );
    return Consumer<UserPlaceProvider>(
      // ignore: non_constant_identifier_names
      builder: (context, UserPlaceValue, child) {
        final userPlace = UserPlaceValue.getUserData();
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MarkerProvider(curPosition: widget.position, userPlace: userPlace),
            ),
            ChangeNotifierProvider(
              create: (context) => PolylineProvider(userPlace: userPlace, position: widget.position),
            ),
          ],
          child: Consumer2<MarkerProvider, PolylineProvider>(
            builder: (context, markerValue, polylineValue, child) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add_alarm),
                  onPressed: () async {
                    final result =
                    await Navigator.pushNamed(context, PlaceInputScreen.id);
                    if (result != null) {
                      markerValue.addMarkerNotifier(userPlace: result);
                      UserPlaceValue.setUserData(result);
                      storage.setItem(userPlace);
                      polylineValue.addRouteNotifier(userPlace: result, position: widget.position);

                    }
                  },
                  backgroundColor: Color.fromRGBO(219, 235, 196, 1.0),
                  foregroundColor: Colors.black,
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                body: Column(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _user,
                            markers: markerValue.getMarkers(),
                            polylines: polylineValue.getPolylines(),
                            trafficEnabled: true,
                            myLocationEnabled: true,
                          )
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.19,
                      child: IndexedStack(
                        index: _currentIndex,
                        children: [
                          InfoCard(
                            child: userPlace == null
                                ? EmptyTile()
                                : DestTile(
                              dest: userPlace.dest,
                            ),
                          ),
                          InfoCard(
                            child: userPlace == null
                                ? EmptyTile()
                                : AlarmTile(
                              value: userPlace.turnON,
                              date: userPlace.date,
                              dest: userPlace.formatURL(),
                              start: '${widget.position.latitude},${widget.position.longitude}',
                              onChanged: (value) {
                                if (value) {
                                  scheduleNotification(plugin, userPlace, 0);
                                } else {
                                  plugin.cancelAll();
                                }
                                UserPlaceValue.changeSwitch(value);
                                storage.setItem(userPlace);
                              },
                            ),
                          ),
                          InfoCard(
                            child: userPlace?.estTime == null
                                ? EmptyTile()
                                : EstTile(
                              userPlace: userPlace,
                              startGeo: widget.position,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: MyBottomNav(
                  currentIndex: _currentIndex,
                  onTap: (index) async {
                    setState(() {
                      _currentIndex = index;
                    });
                    if (index == 2 && userPlace != null) {
                      try {
                        final result = await EstimateTime(
                            userData: userPlace, userGeo: widget.position)
                            .getEstimate();
                        UserPlaceValue.setUserData(result);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
