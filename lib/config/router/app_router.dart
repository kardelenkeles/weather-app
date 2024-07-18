import 'package:auto_route/auto_route.dart';
import 'package:uplide_task/config/router/app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: WeatherDetailRoute.page),
        AutoRoute(page: ExploreRoute.page, initial: true),
      ];
}
