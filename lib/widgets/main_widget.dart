import 'package:flutter/material.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget {
  final String location;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windSpeed;

  MainWidget(
      {required this.location,
      required this.temp,
      required this.tempMin,
      required this.tempMax,
      required this.weather,
      required this.humidity,
      required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        color: Colors.white24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${location.toString()}",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "${temp.toInt().toString()}°",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900),
                )),
            Text(
              "Temp. Max ${tempMax.toInt().toString()}°, Temp. Min. ${tempMin.toInt().toString()}°",
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(children: [
                WeatherTile(
                    icon: Icons.thermostat_outlined,
                    title: "Temperatura",
                    subtitle: "${temp.toInt().toString()}°"),
                WeatherTile(
                    icon: Icons.filter_drama_outlined,
                    title: "Clima",
                    subtitle: "${weather.toString()}"),
                WeatherTile(
                    icon: Icons.wb_sunny,
                    title: "Humidade",
                    subtitle: "${humidity.toString()}%"),
                WeatherTile(
                    icon: Icons.waves,
                    title: "Vento",
                    subtitle: "${windSpeed.toString()}KM/H"),
              ])))
    ]);
  }
}
