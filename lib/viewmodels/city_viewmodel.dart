import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/city_service.dart';

class CityViewModel extends ChangeNotifier {
  List<String> _citySuggestions = [];
  List<String> _lastVisitedCities = [];
  List<Map<String, dynamic>> _weatherData = [];

  bool _isFetchingCities = false;
  bool _isFetchingWeather = false;

  final CityService _cityService = CityService();

  List<String> get citySuggestions => _citySuggestions;
  List<Map<String, dynamic>> get weatherData => _weatherData;
  List<String> get lastVisitedCities => _lastVisitedCities;

  bool get isFetchingCities => _isFetchingCities;
  bool get isFetchingWeather => _isFetchingWeather;

  Future<void> fetchCitySuggestions(String query) async {
    _isFetchingCities = true;
    notifyListeners();

    try {
      _citySuggestions = await _cityService.fetchCitySuggestions(query);
    } catch (e) {
      _citySuggestions = [];
      print('Failed to fetch city suggestions: $e');
    } finally {
      _isFetchingCities = false;
      notifyListeners();
    }
  }

  Future<void> fetchRandomCitiesWeather() async {
    _isFetchingWeather = true;
    notifyListeners();

    try {
      List<String> cities = await _cityService.fetchRandomCities();
      List<Map<String, dynamic>> weatherList = [];

      for (String city in cities) {
        try {
          var weather = await _cityService.fetchWeatherData(city);
          weatherList.add(weather);
        } catch (e) {
          print('Error fetching weather data for $city: $e');
        }
      }

      _weatherData = weatherList;
    } catch (e) {
      _weatherData = [];
      print('Failed to fetch random cities: $e');
    } finally {
      _isFetchingWeather = false;
      notifyListeners();
    }
  }

  Future<void> clearLastVisitedCities() async {
    await _cityService.clearLastVisitedCities();
    _lastVisitedCities = [];
    notifyListeners();
  }

  Future<void> saveLastVisitedCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? lastCities = prefs.getStringList('lastCities') ?? [];
    if (!lastCities.contains(city)) {
      lastCities.add(city);
      await prefs.setStringList('lastCities', lastCities);
    }
  }

  Future<List<String>> getLastVisitedCities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('lastCities') ?? [];
  }
}
