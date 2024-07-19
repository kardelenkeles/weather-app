import 'package:flutter/material.dart';
import 'package:uplide_task/models/forecaster_model.dart';
import 'package:uplide_task/services/weather_service.dart';
import 'package:uplide_task/models/weather_model.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherService _weatherService;
  WeatherModel? _weatherData;
  DailyForecastModel? _forecastResponse;
  bool _isLoading = false;

  WeatherViewModel(this._weatherService);

  WeatherModel? get weatherData => _weatherData  ;
  DailyForecastModel? get forecastResponse => _forecastResponse;
  bool get isLoading => _isLoading;

  Future<void> fetchWeatherData(String cityName) async {
    _isLoading = true;
    notifyListeners();

    try {
     _weatherData = await _weatherService.fetchCurrentWeather(cityName);
      _forecastResponse = await _weatherService.fetchForecast(cityName);

    } catch (e) {
      print('Error fetching weather data: $e');

    }

    _isLoading = false;
    notifyListeners();
  }
}
