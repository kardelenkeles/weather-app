import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uplide_task/models/weather_model.dart';
import 'package:uplide_task/viewmodels/weather_viewmodel.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<ExploreScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
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
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      weatherViewModel.fetchWeather(_cityController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (weatherViewModel.isLoading)
              CircularProgressIndicator()
            else if (weatherViewModel.errorMessage != null)
              Text(
                weatherViewModel.errorMessage!,
                style: TextStyle(color: Colors.red),
              )
            else if (weatherViewModel.weatherList != null)
              Expanded(
                child: ListView.builder(
                  itemCount: weatherViewModel.weatherList!.length,
                  itemBuilder: (context, index) {
                    WeatherModel weather = weatherViewModel.weatherList![index];
                    return ListTile(
                      title: Text(weather.dtTxt ?? ""),
                      subtitle: Text("Temperature: ${weather.main?.temp}°C"),
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
