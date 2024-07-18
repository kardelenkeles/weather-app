// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:uplide_task/view/screens/explore_screen.dart' as _i1;
import 'package:uplide_task/view/screens/home_screen.dart' as _i2;
import 'package:uplide_task/view/screens/splash_screen.dart' as _i3;
import 'package:uplide_task/view/screens/weather_detail_screen.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ExploreRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ExploreScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.HomeScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.SplashScreen(),
      );
    },
    WeatherDetailRoute.name: (routeData) {
      final args = routeData.argsAs<WeatherDetailRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.WeatherDetailScreen(city: args.city),
      );
    },
  };
}

/// generated route for
/// [_i1.ExploreScreen]
class ExploreRoute extends _i5.PageRouteInfo<void> {
  const ExploreRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ExploreRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SplashScreen]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.WeatherDetailScreen]
class WeatherDetailRoute extends _i5.PageRouteInfo<WeatherDetailRouteArgs> {
  WeatherDetailRoute({
    required String city,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          WeatherDetailRoute.name,
          args: WeatherDetailRouteArgs(city: city),
          initialChildren: children,
        );

  static const String name = 'WeatherDetailRoute';

  static const _i5.PageInfo<WeatherDetailRouteArgs> page =
      _i5.PageInfo<WeatherDetailRouteArgs>(name);
}

class WeatherDetailRouteArgs {
  const WeatherDetailRouteArgs({required this.city});

  final String city;

  @override
  String toString() {
    return 'WeatherDetailRouteArgs{city: $city}';
  }
}
