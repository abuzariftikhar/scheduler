import 'package:flutter/material.dart';
import 'package:scheduler/app/consumer/routes.dart';
import 'package:scheduler/ui/splash_page.dart';

import '../app.dart';

final GlobalKey<NavigatorState> consumerNavigatorKey =
    GlobalKey<NavigatorState>();

class ConsumerApp extends StatefulWidget {
  const ConsumerApp({Key? key}) : super(key: key);

  @override
  _ConsumerAppState createState() => _ConsumerAppState();
}

class _ConsumerAppState extends State<ConsumerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Consumer App",
      navigatorKey: consumerNavigatorKey,
      initialRoute: SpalshPage.route,
      onGenerateRoute: generateConsumerRoutes,
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        pageTransitionsTheme: pageTransitionsTheme,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        pageTransitionsTheme: pageTransitionsTheme,
      ),
    );
  }
}
