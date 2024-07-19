import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uplide_task/viewmodels/city_viewmodel.dart';
import 'package:uplide_task/viewmodels/weather_viewmodel.dart';
import 'weather_detail_screen.dart';

@RoutePage()
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

  Future<void> _searchCity() async {
    final cityViewModel = Provider.of<CityViewModel>(context, listen: false);
    final weatherViewModel =
        Provider.of<WeatherViewModel>(context, listen: false);

    final cityName = _cityController.text;

    if (cityName.isNotEmpty) {
      await cityViewModel.fetchCitySuggestions(cityName);

      if (cityViewModel.citySuggestions.contains(cityName)) {
        weatherViewModel.fetchWeatherData(cityName);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherDetailScreen(cityName: cityName),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('City not found'),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() {
        _showLastVisited = false;
      });
    }
  }

  void _toggleShowLastVisited() async {
    final cityViewModel = Provider.of<CityViewModel>(context, listen: false);

    if (_cityController.text.isEmpty) {
      await cityViewModel.getLastVisitedCities();
      setState(() {
        _showLastVisited = !_showLastVisited;
      });
    } else {
      setState(() {
        _showLastVisited = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cityViewModel = Provider.of<CityViewModel>(context);
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
      ),
      appBar: AppBar(
        actions: [
          if (_showLastVisited)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () async {
                await cityViewModel.clearLastVisitedCities();
                setState(() {
                  _showLastVisited = false;
                });
              },
            ),
        ],
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
                  onPressed: _searchCity,
                ),
              ),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  cityViewModel.fetchCitySuggestions(text);
                  setState(() {
                    _showLastVisited = false;
                  });
                }
              },
              onTap: () {
                _toggleShowLastVisited();
              },
            ),
            const SizedBox(height: 20),
            if (_showLastVisited)
              Expanded(
                child: Consumer<CityViewModel>(
                  builder: (context, cityViewModel, child) {
                    return FutureBuilder<List<String>>(
                      future: cityViewModel.getLastVisitedCities(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: snapshot.data!.map((city) {
                              return GestureDetector(
                                onTap: () {
                                  weatherViewModel.fetchWeatherData(city);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WeatherDetailScreen(cityName: city),
                                    ),
                                  );
                                },
                                child: Chip(
                                  label: Text(city),
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return const Center(
                            child: Text('No recent cities visited.'),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            if (!_showLastVisited && cityViewModel.citySuggestions.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: cityViewModel.citySuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cityViewModel.citySuggestions[index]),
                      onTap: () {
                        weatherViewModel.fetchWeatherData(
                            cityViewModel.citySuggestions[index]);
                        cityViewModel.saveLastVisitedCity(
                            cityViewModel.citySuggestions[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeatherDetailScreen(
                              cityName: cityViewModel.citySuggestions[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
