import 'package:flutter/material.dart';
import 'package:partywitty/presentation/screens/splash/view.dart';

import '../../screens/home/view.dart';


class Routes {
  static const String splashPage = '/splash';
  static const String homePage = '/home';
  
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
     
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: SizedBox(child: Center(child: Text("Page Not Found"))),
      ),
    );
  }
}
