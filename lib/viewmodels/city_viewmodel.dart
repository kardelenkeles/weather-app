import 'package:flutter/foundation.dart';
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
}
