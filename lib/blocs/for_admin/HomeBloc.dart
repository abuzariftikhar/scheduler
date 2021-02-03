import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/views/mobile/AddServiceForm.dart';
import 'package:scheduler/views/mobile/ReservationsScreen.dart';
import 'package:scheduler/views/mobile/OrdersScreen.dart';
import 'package:scheduler/views/mobile/QuickEntryScreen.dart';
import 'package:scheduler/views/mobile/ServicesManagement.dart';
import 'package:scheduler/widgets/custom_icons_icons.dart';

import 'ServicesManagerBloc.dart';

class HomeBloc extends ChangeNotifier {
  List<ListItemModel> listItem = [
    ListItemModel(
      routeTo: ChangeNotifierProvider(
          create: (context) => ServicesManagerBloc(),
          child: ServicesManagementScreen()),
      title: 'Services\nManager',
      iconData: CustomIcons.fi_rr_database,
    ),
    ListItemModel(
      routeTo: ReservationsScreen(),
      title: 'View All\nReservations',
      iconData: CustomIcons.fi_rr_stopwatch,
    ),
    ListItemModel(
      routeTo: OrderManagementScreen(),
      title: 'Shop\nSettings',
      iconData: CustomIcons.fi_rr_settings,
    ),
    ListItemModel(
      routeTo: AddServiceForm(),
      title: 'Add\nService',
      iconData: CustomIcons.fi_rr_apps_add,
    ),
  ];
  List<ListItemModel> listItem2 = [
    ListItemModel(
      routeTo: AddServiceForm(),
      title: 'Add New\nService',
      iconData: CustomIcons.fi_rr_apps_add,
    ),
    ListItemModel(
      routeTo: QuickEntryScreen(),
      title: 'Add Quick\nEntry',
      iconData: CustomIcons.fi_rr_rocket,
    ),
    ListItemModel(
      routeTo: OrderManagementScreen(),
      title: 'Adjust\nTaxation',
      iconData: CustomIcons.fi_rr_dollar,
    ),
  ];

  List<ListItemModel> listItem3 = [
    ListItemModel(
      routeTo: OrderManagementScreen(),
      title: 'Sales &\nReports',
      iconData: CustomIcons.fi_rr_stats,
    ),
    ListItemModel(
      routeTo: OrderManagementScreen(),
      title: 'Hosting\nAnalytics',
      iconData: CustomIcons.fi_rr_cloud,
    ),
    ListItemModel(
      routeTo: OrderManagementScreen(),
      title: 'Trends\nReports',
      iconData: CustomIcons.fi_rr_diploma,
    ),
  ];
}

class ListItemModel {
  final String title;
  final IconData iconData;
  final Widget routeTo;

  ListItemModel({
    @required this.title,
    @required this.routeTo,
    @required this.iconData,
  });
}
