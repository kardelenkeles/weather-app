import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uplide_task/models/forecaster_model.dart';

import 'package:uplide_task/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String _baseUrl = dotenv.env['BASE_URL']!;
  final String _apiKey = dotenv.env['API_KEY']!;

  Future<WeatherModel> fetchCurrentWeather(String cityName) async {

    final response = await http.get(
        Uri.parse('$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric'));
    if (response.statusCode == 200) {
      print(WeatherModel.fromJson(json.decode(response.body)));
      return WeatherModel.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<DailyForecastModel> fetchForecast(String cityName) async {
      final response = await http.get(Uri.parse(
          '$_baseUrl/forecast?q=$cityName&appid=$_apiKey&units=metric'));

      if (response.statusCode == 200) {
        return DailyForecastModel.fromJson(json.decode(response.body));
      } else {
        return DailyForecastModel(list: []);
      }



  }
}
