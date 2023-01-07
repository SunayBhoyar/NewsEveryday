import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';

class Weather {
  String icon;
  String oneWordDescription;
  String location;
  double temp;
  double fTemp;
  double mTemp;
  double MTemp;
  int humidity;
  int sealevel;

  //Now let's create the constructor
  Weather({
    required this.icon,
    required this.oneWordDescription,
    required this.location,
    required this.temp,
    required this.fTemp,
    required this.mTemp,
    required this.MTemp,
    required this.humidity,
    required this.sealevel,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      icon: json["weather"][0]["icon"],
      oneWordDescription: json["weather"][0]["main"],
      location: json["name"],
      temp: json["main"]["temp"],
      fTemp: json["main"]["feels_like"],
      mTemp: json["main"]["temp_min"],
      MTemp: json["main"]["temp_max"],
      humidity: json["main"]["humidity"],
      sealevel: json["main"]["sea_level"],
    );
  }
}

class CWeather extends StatefulWidget {
  const CWeather({super.key});

  @override
  State<CWeather> createState() => _CWeatherState();
}

class _CWeatherState extends State<CWeather> {
  var log = "";
  var lat = "";
  Future getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      log = position.longitude.toString();
      lat = position.latitude.toString();
    });
  }

  Future<Weather> fetchWeather() async {
    await getLocation();
    final weatherRecords = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$log&appid=943662680bd623bfbd1dc95c227d6385'));

    if (weatherRecords.statusCode == 200) {
      return Weather.fromJson(jsonDecode(weatherRecords.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<Weather> currentWeather;
  @override
  void initState() {
    super.initState();
    // getLocation();
    currentWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: FutureBuilder<Weather>(
        future: currentWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(30),
              height: 300,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 91, 0, 140),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Min Tempreture - ${(snapshot.data!.mTemp - 273).toStringAsFixed(1)} C°",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Max Tempreture - ${(snapshot.data!.MTemp - 273).toStringAsFixed(1)} C°",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${(snapshot.data!.temp - 273).toStringAsFixed(1)} C°",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "It feels like - ${(snapshot.data!.fTemp - 273).toStringAsFixed(1)} C°",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: Image.network(
                          "http://openweathermap.org/img/wn/${snapshot.data!.icon}@2x.png"),
                    ),
                    Text(
                      snapshot.data!.oneWordDescription,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ]),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return LoadingBouncingLine.circle();
        },
      ),
    );
  }
}
