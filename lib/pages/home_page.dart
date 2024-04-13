import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/components/weather_card.dart';
import 'package:myapp/models/WeatherInformation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationData? locationData;
  WeatherResponse? weatherData;
  late bool shouldDisplayMissingLocationError = false;

  void _getWeatherInformation() async {
    await _getCurrentLocation();

    if (locationData == null) {
      return;
    }

    double? latitude = locationData!.latitude;
    double? longitude = locationData!.longitude;

    if (latitude == null || longitude == null) {
      return;
    }

    Future<http.Response> weatherResponse = http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=91470720125fda0472f742a696a931da"));

    http.Response response = await weatherResponse;
    
    if (response.statusCode == 200) {
      var weres = WeatherResponse.fromJson(jsonDecode(response.body));

      setState(() {
        weatherData = weres;
      });
    } else {
      // If the server returns an error response, throw an exception.
      throw Exception('Failed to load weather information');
    }
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() {
            shouldDisplayMissingLocationError = true;
          });
          print(shouldDisplayMissingLocationError.toString());
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

      _locationData = await location.getLocation();

      setState(() {
        locationData = _locationData;
      });
    } catch (e) {
      setState(() {
        shouldDisplayMissingLocationError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 231, 231),
      appBar: AppBar(
        title:
            const Text("WeatherApp.io", style: TextStyle(color: Colors.grey)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
      ),
      body: Center(
        child: weatherData == null ? 
          (shouldDisplayMissingLocationError
            ? const Text("Error: no location permission given.")
            : ElevatedButton(
                onPressed: _getWeatherInformation,
                child: const Text("Get weather information"),
              ))
               :  WeatherCard(weatherData: weatherData as WeatherResponse),
    ));
  }
}
