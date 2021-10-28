import 'package:flutter/material.dart';
import 'widgets/main_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<WeatherInfo> fetchWeather() async {
  final city = "Joinville";
  final apiKey = "3812e0f6b2dc480191e4007aaaf6b9df";
  final requestUrl =
      "https://api.openweathermap.org/data/2.5/weather?q=${city},br&units=metric&lang=Pt_br&appid=${apiKey}";

  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Erro ao carregar a informação da URl");
  }
}

class WeatherInfo {
  final location;
  final temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windSpeed;

  WeatherInfo(
      {required this.location,
      required this.temp,
      required this.tempMax,
      required this.tempMin,
      required this.weather,
      required this.humidity,
      required this.windSpeed});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        location: json['name'],
        temp: json['main']['temp'],
        tempMin: json['main']['temp_min'],
        tempMax: json['main']['temp_max'],
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed']);
  }
}

void main() {
  runApp(MaterialApp(title: "Aplicativo de Previsão", home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<WeatherInfo>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MainWidget(
                  location: snapshot.data!.location,
                  temp: snapshot.data!.temp,
                  tempMin: snapshot.data!.tempMin,
                  tempMax: snapshot.data!.tempMax,
                  weather: snapshot.data!.weather,
                  humidity: snapshot.data!.humidity,
                  windSpeed: snapshot.data!.windSpeed,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
