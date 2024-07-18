import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Explore Screen'),
      ),
    );
  }
}
