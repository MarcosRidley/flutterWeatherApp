import 'package:flutter/material.dart';
import 'package:myapp/models/WeatherInformation.dart';

class WeatherCard extends StatefulWidget {
  final WeatherResponse weatherData;

  const WeatherCard({super.key, required this.weatherData});

  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = widget.weatherData;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
          _animationController.forward();
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _animationController.reverse();
        });
      },
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weatherData.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://openweathermap.org/img/wn/${weatherData.weather.first.icon}@2x.png',
                      width: 48,
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${(weatherData.main.temp - 273).toStringAsFixed(1)}°C / ${(weatherData.main.temp.floor() * 9 / 5 - 459.7).toStringAsFixed((1))}°F',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Feels like: ${(weatherData.main.temp - 273).toStringAsFixed(1)}°C / ${(weatherData.main.temp.floor() * 9 / 5 - 459.7).toStringAsFixed((1))}°F',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          weatherData.weather.first.description,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _WeatherInfo(
                        icon: Icons.water_drop_outlined,
                        label: 'Humidity',
                        value: '${weatherData.main.humidity}%'),
                    _WeatherInfo(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: '${weatherData.wind.speed} m/s',
                    ),
                    _WeatherInfo(
                        icon: Icons.arrow_downward,
                        label: 'Atmospheric Pressure',
                        value: '${weatherData.main.pressure} hPa'),
                    _WeatherInfo(
                      icon: Icons.panorama_fish_eye_sharp,
                      label: 'Visibility',
                      value: '${weatherData.visibility} m',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24.0, color: Theme.of(context).primaryColor),
        const SizedBox(height: 4.0),
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
