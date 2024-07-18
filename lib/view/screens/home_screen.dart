import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uplide_task/viewmodels/weather_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter city'),
              onSubmitted: (value) {
                viewModel.fetchWeather(value);
              },
            ),
            const SizedBox(height: 20),
            if (viewModel.isLoading)
              const CircularProgressIndicator()
            else if (viewModel.errorMessage.isNotEmpty)
              Text(viewModel.errorMessage)
            else
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.weatherList.length,
                  itemBuilder: (context, index) {
                    final weather = viewModel.weatherList[index];
                    return ListTile(
                      title: Text(weather.dtTxt ?? ''),
                      subtitle: Text(
                        'Temp: ${weather.main?.temp}°C, ${weather.weather?[0].description}',
                      ),
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
