import 'package:flutter/material.dart';
import 'package:partywitty/presentation/screens/bottom_nav/view.dart';
import 'package:partywitty/presentation/screens/reel/view.dart';
import 'package:partywitty/presentation/screens/splash/view.dart';
import 'package:partywitty/presentation/widgets/multi_img_reel.dart';
import 'package:partywitty/presentation/widgets/single_img_reel.dart';
import 'package:partywitty/presentation/widgets/video_reel.dart';

import '../../screens/home/view.dart';


class Routes {
  static const String splashPage = '/splash';
  static const String homePage = '/home';
    static const String bottomNav = '/bottomNav';
    static const String reelPage = '/reelPage';
        static const String multiImgPage = '/multiImgPage';
    static const String singleImgPage = '/singleImgPage';
    static const String videoPage = '/videoPage';


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
        // case Routes.reelPage:
        // return MaterialPageRoute(builder: (_) =>  ReelPage(),settings: routeSettings);
         case Routes.multiImgPage:
        return MaterialPageRoute(builder: (_) =>  MultiImgReel(),settings: routeSettings);
         case Routes.singleImgPage:
        return MaterialPageRoute(builder: (_) =>  SingleImgReel(),settings: routeSettings);
         case Routes.videoPage:
        // return MaterialPageRoute(builder: (_) =>  VideoReel(),settings: routeSettings);
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
