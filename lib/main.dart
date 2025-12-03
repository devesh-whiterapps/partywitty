import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

import 'presentation/resources/router/route_manager.dart';
import 'presentation/resources/theme/theme_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Party Witty',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashPage,
      theme: getApplicationTheme(),
    );
  }
}