import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String city = 'Puebla';
  final String lang = 'es';
  final String apiKey = '';
  final String baseUrl = 'http://api.weatherapi.com/v1/current.json?';

  Future<WeatherResponse> getWeather() async {
    final url = Uri.parse('$baseUrl&key=$apiKey&q=$city&lang=$lang');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherResponse(
          status: true,
          body: Weather(
            city: data["location"]["name"],
            temp: data["current"]["temp_c"].toString(),
            condition: data["current"]["condition"]["text"],
            icon: data["current"]["condition"]["icon"],
          ),
        );
      } else {
        throw Exception('Error al obtener el clima');
      }
    } catch (e) {
      return WeatherResponse(status: false, body: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clima'), centerTitle: true),
      body: FutureBuilder<WeatherResponse>(
        future: getWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              !snapshot.data!.status) {
            return Center(child: Text('Error al obtener el clima'));
          } else {
            // Obtener los datos del clima de la respuesta
            Weather weather = snapshot.data!.body!;
            return WeatherCard(
              weather: weather,
            ); // Pasamos los datos de clima aquí
          }
        },
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 500,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'El clima en ${weather.city}', // Usamos el nombre de la ciudad
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
              Text('${weather.temp}°', style: TextStyle(fontSize: 90)),
              SizedBox(height: 10),
              Image.network(
                'https:${weather.icon}', // Usamos el ícono del clima desde la API
                width: 64,
                height: 64,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Text(
                weather.condition, // Condición del clima
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Weather {
  final String city;
  final String temp;
  final String condition;
  final String icon;

  Weather({
    required this.temp,
    required this.condition,
    required this.icon,
    required this.city,
  });
}

class WeatherResponse {
  final bool status;
  final Weather? body;
  WeatherResponse({required this.status, required this.body});
}
