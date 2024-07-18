import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplide_task/services/city_service.dart';

class CityViewModel extends ChangeNotifier {
  List<String> _citySuggestions = [];
  bool _isFetchingCities = false;

  List<String> get citySuggestions => _citySuggestions;
  bool get isFetchingCities => _isFetchingCities;

  final CityService _cityService = CityService();

  Future<void> fetchCitySuggestions(String query) async {
    _isFetchingCities = true;
    notifyListeners();

    try {
      _citySuggestions = await _cityService.fetchCitySuggestions(query);
    } catch (e) {
      _citySuggestions = [];
    } finally {
      _isFetchingCities = false;
      notifyListeners();
    }
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
