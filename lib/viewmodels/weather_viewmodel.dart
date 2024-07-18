import 'package:flutter/material.dart';
import 'package:uplide_task/models/weather_model.dart';
import 'package:uplide_task/services/weather_service.dart';

class WeatherViewModel with ChangeNotifier {
  List<WeatherModel>? _weatherList;
  bool _isLoading = false;
  String? _errorMessage;

  List<WeatherModel>? get weatherList => _weatherList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _weatherList = await _weatherService.fetchWeather(city);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
