import 'package:flutter/material.dart';

class AppointmentsBloc extends ChangeNotifier {
  int index = 0;
  int day = 0;
  List<AppointmentModel> listOfSchedule = [
    AppointmentModel(
      startTime: DateTime.now(),
      status: 'Served',
      customerName: 'John ivy',
      date: '14-11-2020',
      listOfType: [
        AppointmentType(typeName: 'Hair Cut', timeRequired: '30 minutes'),
        AppointmentType(typeName: 'Facial', timeRequired: '60 minutes'),
      ],
    ),
    AppointmentModel(
      status: 'Checked-in',
      startTime: DateTime.now(),
      customerName: 'Williams',
      date: '14-11-2020',
      listOfType: [
        AppointmentType(typeName: 'Menicure', timeRequired: '60 minutes'),
      ],
    ),
    AppointmentModel(
      status: 'Pending',
      startTime: DateTime.now(),
      customerName: 'Henry wills',
      date: '14-11-2020',
      listOfType: [
        AppointmentType(typeName: 'Menicure', timeRequired: '60 minutes'),
      ],
    ),
    AppointmentModel(
      status: 'Served',
      startTime: DateTime.now(),
      customerName: 'Henry wills',
      date: '14-11-2020',
      listOfType: [
        AppointmentType(typeName: 'Menicure', timeRequired: '60 minutes'),
      ],
    ),
    AppointmentModel(
      status: 'Served',
      startTime: DateTime.now(),
      customerName: 'Henry wills',
      date: '14-11-2020',
      listOfType: [
        AppointmentType(typeName: 'Menicure', timeRequired: '60 minutes'),
      ],
    ),
    AppointmentModel(
      status: 'Cancelled',
      startTime: DateTime.now(),
      customerName: 'Henry wills',
      date: '14-11-2020',
      listOfType: [
        AppointmentType(typeName: 'Menicure', timeRequired: '60 minutes'),
      ],
    ),
    AppointmentModel(
      status: 'Served',
      startTime: DateTime.now(),
      customerName: 'Henry wills',
      date: '14-11-2020',
      listOfType: [
        AppointmentType(typeName: 'Menicure', timeRequired: '60 minutes'),
      ],
    ),
    AppointmentModel(
      status: 'Served',
      startTime: DateTime.now(),
      customerName: 'David',
      date: '14-11-2020',
      listOfType: [
        AppointmentType(typeName: 'Menicure', timeRequired: '60 minutes'),
      ],
    ),
  ];

  void update() {
    notifyListeners();
  }
}

class AppointmentModel {
  final String customerName;
  final DateTime startTime;
  final String date;
  final String status;
  final List<AppointmentType> listOfType;

  AppointmentModel({
    @required this.startTime,
    @required this.customerName,
    @required this.status,
    @required this.date,
    @required this.listOfType,
  });
}

class AppointmentType {
  final String typeName;
  final String timeRequired;

  AppointmentType({
    @required this.typeName,
    @required this.timeRequired,
  });
}
