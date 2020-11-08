import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  final weatherdata;
  LocationScreen(this.weatherdata);
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  void initState() {
    super.initState();
    updateui(widget.weatherdata);

  }
  String emoji = '';
  String message = '';
  int temperature;
  int condition;
  String city;
  WeatherModel weather = WeatherModel();
  void updateui(dynamic weatherdata){
    setState(() {

      if(weatherdata == null){
        print('ddd');
        temperature = 0;
        emoji = 'Error';
        message = 'unable to get weather data';
        city ='';
        return;
      }

      var temp = weatherdata['main']['temp'];

      temperature = temp.toInt();
      condition = weatherdata['weather'][0]['id'];
      emoji = weather.getWeatherIcon(condition);
      message = weather.getMessage(temperature);
      city = weatherdata['name'];

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      updateui(widget.weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var newName = await Navigator.push(context, MaterialPageRoute(builder: (Context){
                        return CityScreen();
                      }),
                      );
                      if(newName!=null){
                        var temp = await weather.getNew(newName);
                        updateui(temp);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      emoji,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $city',
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
