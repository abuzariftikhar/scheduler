import 'package:flutter/material.dart';
import 'package:scheduler/app/vendor/routes.dart';
import 'package:scheduler/ui/splash_page.dart';

final GlobalKey<NavigatorState> vendorNavigatorKey =
    GlobalKey<NavigatorState>();

class VendorApp extends StatefulWidget {
  const VendorApp({Key? key}) : super(key: key);

  @override
  _VendorAppState createState() => _VendorAppState();
}

class _VendorAppState extends State<VendorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vendor App",
      navigatorKey: vendorNavigatorKey,
      initialRoute: SpalshPage.route,
      onGenerateRoute: generateVendorRoutes,
    );
  }
}
