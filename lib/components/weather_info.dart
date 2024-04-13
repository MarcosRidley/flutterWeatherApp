import 'package:flutter/material.dart';
import 'package:myapp/models/WeatherInformation.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key, required this.weatherData});

  final WeatherResponse weatherData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Weather in ${weatherData.name}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Temperature: ${weatherData.main.temp}°C",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Feels like: ${weatherData.main.feelsLike}°C",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Humidity: ${weatherData.main.humidity}%",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Wind speed: ${weatherData.wind.speed} m/s",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}