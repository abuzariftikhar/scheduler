import 'package:flutter/material.dart';
import 'package:scheduler/ui/vendor/home_page.dart';

Route<dynamic>? generateVendorRoutes(RouteSettings settings) {
  switch (settings.name) {
    case VendorHomePage.route:
      return MaterialPageRoute(
        builder: (context) => VendorHomePage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => VendorHomePage(),
      );
  }
}
