import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uplide_task/viewmodels/city_viewmodel.dart';
import 'package:uplide_task/view/screens/weather_detail_screen.dart';
import 'package:uplide_task/view/screens/explore_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Provider.of<CityViewModel>(context, listen: false)
        .fetchRandomCitiesWeather();
  }

  Future<void> _refreshWeatherData() async {
    await Provider.of<CityViewModel>(context, listen: false)
        .fetchRandomCitiesWeather();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavBarTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          RefreshIndicator(
            onRefresh: _refreshWeatherData,
            child: Consumer<CityViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isFetchingCities) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.weatherData.isEmpty) {
                  return const Center(child: Text('No weather data available'));
                }

                return ListView.builder(
                  itemCount: viewModel.weatherData.length,
                  itemBuilder: (context, index) {
                    var weather = viewModel.weatherData[index];
                    String city = weather['name'];
                    dynamic temperature = weather['main']['temp'];
                    String description = weather['weather'][0]['description'];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(city),
                        subtitle: Text(
                            'Temperature: $temperature°C\nDescription: $description'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WeatherDetailScreen(cityName: city),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ExploreScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavBarTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
