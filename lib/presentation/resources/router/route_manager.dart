import 'package:flutter/material.dart';
import 'package:partywitty/presentation/screens/bottom_nav/view.dart';
import 'package:partywitty/presentation/screens/reel/view.dart';
import 'package:partywitty/presentation/screens/splash/view.dart';

import '../../screens/home/view.dart';


class Routes {
  static const String splashPage = '/splash';
  static const String homePage = '/home';
    static const String bottomNav = '/bottomNav';
    static const String reelPage = '/reelPage';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashPage:
        return MaterialPageRoute(builder: (_) =>  SplashPage(),settings: routeSettings);
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) =>  HomePage(),settings: routeSettings);
       case Routes.bottomNav:
        return MaterialPageRoute(builder: (_) =>  BottomNavPage(),settings: routeSettings);
        case Routes.reelPage:
        return MaterialPageRoute(builder: (_) =>  ReelPage(),settings: routeSettings);
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
