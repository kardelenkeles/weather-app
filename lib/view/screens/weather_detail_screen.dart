import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WeatherDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Detail Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Weather Detail Screen'),
      ),
    );
  }
}
