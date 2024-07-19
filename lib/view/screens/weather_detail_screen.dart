import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uplide_task/models/forecaster_model.dart';
import 'package:uplide_task/models/weather_model.dart';
import 'package:uplide_task/services/weather_service.dart';
import 'package:uplide_task/viewmodels/weather_viewmodel.dart';

class WeatherDetailScreen extends StatefulWidget {
  final String cityName;

  WeatherDetailScreen({required this.cityName});

  @override
  _WeatherDetailScreenState createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  late WeatherViewModel _weatherViewModel;

  @override
  void initState() {
    super.initState();
    _weatherViewModel = WeatherViewModel(WeatherService());
    _fetchWeatherData();
  }

  void _fetchWeatherData() async {
    await _weatherViewModel.fetchWeatherData(widget.cityName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _weatherViewModel,
      child: Consumer<WeatherViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (viewModel.weatherData == null) {
            return Scaffold(
              body: Center(child: Text('No data available')),
            );
          }

          final weatherModel = viewModel.weatherData!;
          final temp = weatherModel.main?.temp?.toString() ?? 'N/A';
          final feelsLike = weatherModel.main?.feelsLike?.toString() ?? 'N/A';
          final humidity = weatherModel.main?.humidity?.toString() ?? 'N/A';
          final windSpeed = weatherModel.wind?.speed?.toString() ?? 'N/A';
          final iconCode = weatherModel.weather?.first.icon ?? '';
          final description = weatherModel.weather?.first.description ?? '';
          final pressure = weatherModel.main?.pressure?.toString() ?? 'N/A';

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('${widget.cityName}'),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.5,
                            child: Image.network(
                              'http://openweathermap.org/img/wn/$iconCode@2x.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${temp}°C',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withOpacity(0.5),
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '$description',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildWeatherDetailCard(Icons.thermostat,
                                      'Temperature', '${temp}°C'),
                                  SizedBox(height: 16),
                                  _buildWeatherDetailCard(Icons.accessibility,
                                      'Feels Like', '${feelsLike}°C'),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: _buildCombinedWeatherDetailCard(
                                  humidity, pressure, windSpeed),
                            ),
                          ],
                        ),
                      ),
                     if (viewModel.forecastResponse != null) ...[
                        _buildHorizontalDailyForecast(
                            viewModel.forecastResponse!),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeatherDetailCard(IconData icon, String title, String data) {
    return Card(
      color: Colors.white.withOpacity(0.3),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.blueAccent),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    data,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedWeatherDetailCard(
      String humidity, String pressure, String windSpeed) {
    return Card(
      color: Colors.white.withOpacity(0.3),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Weather Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(Icons.water_drop, 'Humidity', '$humidity%'),
                _buildDetailRow(Icons.speed, 'Pressure', '$pressure hPa'),
                _buildDetailRow(Icons.air, 'Wind Speed', '$windSpeed m/s'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String data) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueAccent),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            '$title: $data',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalDailyForecast(DailyForecastModel forecastResponse) {
    print(forecastResponse.list.length);
    return Card(
      color: Colors.white.withOpacity(0.3),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '24-hour Forecast',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: forecastResponse.list.map((forecast) {
                    final date = forecast.dtTxt?.substring(11, 16) ??
                        'N/A';
                    final temp = forecast.main?.temp?.toString() ?? 'N/A';
                    final iconCode = forecast.weather?.first.icon ?? '';
                    final iconUrl =
                        'http://openweathermap.org/img/wn/$iconCode@2x.png';

                    return Container(
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(date, style: TextStyle(fontSize: 12)),
                          Image.network(iconUrl, width: 40, height: 40),
                          SizedBox(height: 8),
                          Text('$temp°C', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
