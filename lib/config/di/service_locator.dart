import 'package:get_it/get_it.dart';
import 'package:uplide_task/services/weather_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WeatherService());
}
