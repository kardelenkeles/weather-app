import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CityService {
  final String _baseUrl = dotenv.env['BASE_URL']!;
  final String _apiKey = dotenv.env['API_KEY']!;

  Future<List<String>> fetchRandomCities() async {
    const Map<String, int> capitals = {
      'London': 2643743,
      'New York': 5128581,
      'Tokyo': 1850147,
      'Paris': 2988507,
      'Sydney': 2147714,
      'Berlin': 2950159,
      'Ottawa': 6094817,
      'Moscow': 524901,
      'Beijing': 1816670,
      'Brasília': 3469058,
      'Madrid': 3117735,
      'Rome': 3169070,
      'Cairo': 360630,
      'Buenos Aires': 3435910,
      'Mexico City': 3530597,
      'Jakarta': 1642911,
      'Seoul': 1835848,
      'Lima': 3936456,
      'Hong Kong': 1819729,
      'Sao Paulo': 3448439,
    };

    List<String> cities = capitals.keys.toList();
    cities.shuffle(Random());
    return cities.take(5).toList();
  }

  Future<Map<String, dynamic>> fetchWeatherData(String cityName) async {
    final response = await http.get(Uri.parse(
        "${_baseUrl}weather?q=$cityName&units=metric&appid=$_apiKey"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<void> clearLastVisitedCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<List<String>> fetchCitySuggestions(String query) async {
    final response =
        await http.get(Uri.parse("${_baseUrl}find?q=$query&appid=$_apiKey"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['list'] != null) {
        List<String> cityNames =
            List<String>.from(data['list'].map((city) => city['name']));
        return cityNames.toSet().toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load city suggestions');
    }
  }
}
