import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CityService {
  final String _baseUrl = "http://api.openweathermap.org/data/2.5/find";
  final String _apiKey = dotenv.env['API_KEY'].toString();

  Future<List<String>> fetchCitySuggestions(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl?q=$query&type=like&appid=$_apiKey"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['list'] != null) {
        List<String> cityNames = List<String>.from(data['list'].map((city) => city['name']));
        return cityNames.toSet().toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load city suggestions');
    }
  }
}
