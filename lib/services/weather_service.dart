import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:uplide_task/models/weather_model.dart';

class WeatherService {
  final String apiKey = dotenv.env['API_KEY']!;
  final String baseUrl = 'http://api.openweathermap.org/data/2.5';

  Future<List<WeatherModel>> fetchWeather(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<WeatherModel> weatherList = [];
      jsonData['list'].forEach((v) {
        weatherList.add(WeatherModel.fromJson(v));
      });
      return weatherList;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
