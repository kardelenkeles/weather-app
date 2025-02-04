import 'package:get_it/get_it.dart';
import 'package:uplide_task/config/router/app_router.dart';
import 'package:uplide_task/services/city_service.dart';
import 'package:uplide_task/services/weather_service.dart';
import 'package:uplide_task/viewmodels/city_viewmodel.dart';
import 'package:uplide_task/viewmodels/weather_viewmodel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WeatherService());
  locator.registerLazySingleton(() => WeatherViewModel(locator<WeatherService>()));
  locator.registerLazySingleton(() => CityService());
  locator.registerLazySingleton(() => CityViewModel());

  // router
  locator.registerLazySingleton(() => AppRouter());
  
}
