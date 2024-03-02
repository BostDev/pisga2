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
    final apiKey = '0af91b7826854c791de8fa120991d2e3';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?zip=94040,us&appid';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = json.decode(response.body);
    setState(() {
      temperature = "${decodedResponse['main']['temp']}°C";
      condition = decodedResponse['weather'][0]['main'];
    });
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
        title: Text(
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
            Icon(
              Icons.cloud,
              size: 100.0,
              color: Colors.white,
            ),
            SizedBox(height: 20.0),
            Text(
              'Davao City',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Temperature: $temperature',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
            Text(
              'Condition: $condition',
              style: TextStyle(
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
