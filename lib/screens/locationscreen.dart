// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuelapp/screens/fueldetailsscreen.dart';
import 'package:fuelapp/services/drawer.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({Key key}) : super(key: key);

  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  LocationData _currentPosition;
  String address;
  Completer<GoogleMapController> controller = Completer();
  Marker marker;
  Location location = Location();
  LatLng _initialcameraposition = const LatLng(25.19002, 79.863465);
  //bool currentloc = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getLoc();
    dowork();
  }

  void _onMapCreated(GoogleMapController _cntlr) async {
    controller.complete(_cntlr);
    GoogleMapController mapController = await controller.future;
    location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
    setState(() {});
  }

  bool _myLocationButtonEnabled = false;
  bool _myLocationEnabled = false;

  Future<void> dowork() async {
    await Future.delayed(
      Duration(seconds: 5),
    );
    for (int i = 0; i < 3; i++) {
      setState(() {
        _myLocationEnabled = true;
        _myLocationButtonEnabled = true;
      });
    }
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: SafeArea(
            child: Container(
              color: Colors.blue,
              child: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: 128.0,
                      height: 128.0,
                      margin: const EdgeInsets.only(
                        top: 24.0,
                        bottom: 64.0,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/register.png',
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.account_circle_rounded),
                      title: Text('Profile'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.favorite),
                      title: Text('Orders'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                    Spacer(),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Text('Terms of Service | Privacy Policy'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialcameraposition, zoom: 15),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: _myLocationEnabled,
                  myLocationButtonEnabled: _myLocationButtonEnabled,
                ),
              ),
              address != null
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 10,
                        ),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FualDetailsScreen()));
                          },
                          elevation: 0,
                          color: Colors.green,
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Positioned(
                top: 12,
                left: 12,
                child: InkWell(
                  onTap: () {
                    _openDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.menu,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();

    // print(" Latitude:: ${_currentPosition.latitude}");
    // print(" Longitude:: ${_currentPosition.longitude}");

    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);

    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);

        _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {
            address = value.first.addressLine.toString();
            // print(address);
          });
        });
      });
    });
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
}
