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
  bool _showLastVisited = false;

  @override
  void initState() {
    super.initState();
    _loadLastVisitedCities();
  }

  Future<void> _loadLastVisitedCities() async {
    final cityViewModel = Provider.of<CityViewModel>(context, listen: false);
    await cityViewModel.getLastVisitedCities();
  }

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            if (cityViewModel.citySuggestions.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: cityViewModel.citySuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cityViewModel.citySuggestions[index]),
                      onTap: () {
                        weatherViewModel
                            .fetchWeather(cityViewModel.citySuggestions[index]);
                        cityViewModel.saveLastVisitedCity(
                            cityViewModel.citySuggestions[index]);
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
            InkWell(
              onTap: () {
                setState(() {
                  _showLastVisited = !_showLastVisited;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history),
                  const SizedBox(width: 8),
                  const Text('Last Visited Cities'),
                ],
              ),
            ),
            if (_showLastVisited)
              Expanded(
                child: FutureBuilder<List<String>>(
                  future: cityViewModel.getLastVisitedCities(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index]),
                            onTap: () {
                              weatherViewModel
                                  .fetchWeather(snapshot.data![index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WeatherDetailScreen(
                                      city: snapshot.data![index]),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No recent cities visited.'),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
