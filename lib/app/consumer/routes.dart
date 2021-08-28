
import 'package:flutter/material.dart';
import 'package:scheduler/ui/consumer/home_page.dart';

Route<dynamic>? generateConsumerRoutes(RouteSettings settings) {
  switch (settings.name) {
    case ConsumerHomePage.route:
      return MaterialPageRoute(
        builder: (context) => ConsumerHomePage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => ConsumerHomePage(),
      );

  }
}
