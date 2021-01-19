import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/views/mobile/AddServiceForm.dart';
import 'package:scheduler/views/mobile/ReservationsScreen.dart';
import 'package:scheduler/views/mobile/OrdersScreen.dart';
import 'package:scheduler/views/mobile/ServeCustomerScreen.dart';
import 'package:scheduler/views/mobile/ServicesManagement.dart';

import 'ServicesManagerBloc.dart';

class HomeBloc extends ChangeNotifier {
  List<ListItemModel> listItem = [
    ListItemModel(
      routeTo: ReservationsScreen(),
      title: 'View\nReservation',
      imageURL: 'assets/to-do.png',
      color: Colors.red.shade50,
    ),
    ListItemModel(
      routeTo: ServeCustomerScreen(),
      title: 'Serve a\nCustomer',
      imageURL: 'assets/hair-dryer.png',
      color: Colors.orange.shade50,
    ),
    ListItemModel(
      routeTo: ChangeNotifierProvider(
          create: (context) => ServicesManagerBloc(),
          child: ServicesManagementScreen()),
      title: 'Manage\nServices',
      imageURL: 'assets/strategy.png',
      color: Colors.blueGrey.shade50,
    ),
    ListItemModel(
      routeTo: AddServiceForm(),
      title: 'Add\nService',
      imageURL: 'assets/layout.png',
      color: Colors.lightGreen.shade50,
    ),
  ];
  List<ListItemModel> listItem2 = [
    ListItemModel(
      routeTo: OrderManagementScreen(),
      title: 'Create\n Item',
      imageURL: 'assets/branding.png',
      color: Colors.blueGrey.shade50,
    ),
    ListItemModel(
      routeTo: OrderManagementScreen(),
      title: 'Create\nMenu',
      imageURL: 'assets/strategy.png',
      color: Colors.blue.shade50,
    ),
    ListItemModel(
      routeTo: OrderManagementScreen(),
      title: 'Adjust\nTaxation',
      imageURL: 'assets/layout.png',
      color: Colors.purple.shade50,
    ),
  ];
}

class ListItemModel {
  final String title;
  final String imageURL;
  final Color color;
  final Widget routeTo;

  ListItemModel({
    @required this.title,
    @required this.routeTo,
    @required this.imageURL,
    @required this.color,
  });
}
