import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:uplide_task/models/weather_model.dart';


class WeatherService {
  final String _baseUrl = "http://api.openweathermap.org/data/2.5/forecast";
  final String _apiKey = dotenv.env['API_KEY'].toString();

  Future<List<WeatherModel>> fetchWeather(String city) async {
    final response = await http.get(Uri.parse("$_baseUrl?q=$city&appid=$_apiKey&units=metric"));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> list = json['list'];
      List<WeatherModel> weatherList = list.map((data) => WeatherModel.fromJson(data)).toList();
      return weatherList;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
