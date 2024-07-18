import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uplide_task/models/weather_model.dart';
import 'package:uplide_task/view/screens/weather_detail_screen.dart';
import 'package:uplide_task/viewmodels/city_viewmodel.dart';
import 'package:uplide_task/viewmodels/weather_viewmodel.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cityViewModel = Provider.of<CityViewModel>(context);
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      cityViewModel.fetchCitySuggestions(_cityController.text);
                    }
                  },
                ),
              ),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  cityViewModel.fetchCitySuggestions(text);
                }
              },
            ),
            const SizedBox(height: 20),
            if (cityViewModel.isFetchingCities)
              const CircularProgressIndicator()
            else if (cityViewModel.citySuggestions.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: cityViewModel.citySuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cityViewModel.citySuggestions[index]),
                      onTap: () {
                        weatherViewModel
                            .fetchWeather(cityViewModel.citySuggestions[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeatherDetailScreen(
                                city: cityViewModel.citySuggestions[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            if (weatherViewModel.isLoading)
              const CircularProgressIndicator()
            else if (weatherViewModel.errorMessage != null)
              Text(
                weatherViewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
          ],
        ),
      ),
    );
  }
}
