import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uplide_task/viewmodels/weather_viewmodel.dart';
import 'package:uplide_task/models/weather_model.dart';

class WeatherDetailScreen extends StatelessWidget {
  final String city;

  WeatherDetailScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('$city Weather Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weatherViewModel.isLoading
            ? Center(child: CircularProgressIndicator())
            : weatherViewModel.errorMessage != null
                ? Text(
                    weatherViewModel.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  )
                : ListView.builder(
                    itemCount: weatherViewModel.weatherList?.length ?? 0,
                    itemBuilder: (context, index) {
                      WeatherModel weather =
                          weatherViewModel.weatherList![index];
                      return ListTile(
                        title: Text(weather.dtTxt ?? ""),
                        subtitle: Text("Temperature: ${weather.main?.temp}°C"),
                      );
                    },
                  ),
      ),
    );
  }
}
