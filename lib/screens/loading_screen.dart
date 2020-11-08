import 'dart:convert';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


double lon;
double lat;
String url;
String id;
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocation() async{
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitude;
    lon = location.longitude;
    id = 'b3928f7d93dc45c2e6007bb25197dffe';
    url =  'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$id&units=metric';
    Network network = Network(url);
    var weatherdata = await network.getLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherdata);
    }) );
  }
  @override
  void initState() {
    super.initState();
    getLocation();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
