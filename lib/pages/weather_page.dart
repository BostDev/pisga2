// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late String cityName = "Davao";
  late String temperature = "";
  late String condition = "";

  Future<void> fetchWeatherData() async {
    const apiKey = '0af91b7826854c791de8fa120991d2e3';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'; // Updated URL
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        setState(() {
          temperature = "${decodedResponse['main']['temp']}°C";
          condition = decodedResponse['weather'][0]['main'];
        });
      } else {
        // Handle error
        print(
            'Failed to load weather data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Error fetching weather data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Weather Update",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud,
              size: 100.0,
              color: Colors.white,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Davao City',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Temperature: $temperature',
              style: const TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
            Text(
              'Condition: $condition',
              style: const TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
