import 'package:flutter/material.dart';
import 'package:scheduler/app/consumer/app_consumer.dart';

import 'vendor/app_vendor.dart';

class SchedulerApp extends StatefulWidget {
  const SchedulerApp({Key? key, required this.appType}) : super(key: key);

  final AppType appType;
  @override
  _SchedulerAppState createState() => _SchedulerAppState();
}

class _SchedulerAppState extends State<SchedulerApp> {
  @override
  Widget build(BuildContext context) {
    switch (widget.appType) {
      case AppType.Consumer:
        return ConsumerApp();
      case AppType.Vendor:
        return VendorApp();
    }
  }
}

final pageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: ZoomPageTransitionsBuilder(),
    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.windows: ZoomPageTransitionsBuilder(),
  },
);

enum AppType {
  Consumer,
  Vendor,
}
