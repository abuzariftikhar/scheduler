import 'package:flutter/material.dart';
import 'package:scheduler/app/consumer/routes.dart';
import 'package:scheduler/ui/splash_page.dart';

final GlobalKey<NavigatorState> consumerNavigatorKey =
    GlobalKey<NavigatorState>();

class ConumerApp extends StatefulWidget {
  const ConumerApp({Key? key}) : super(key: key);

  @override
  _ConumerAppState createState() => _ConumerAppState();
}

class _ConumerAppState extends State<ConumerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Consumer App",
      navigatorKey: consumerNavigatorKey,
      initialRoute: SpalshPage.route,
      onGenerateRoute: generateConsumerRoutes,
    );
  }
}
