import 'package:flutter/material.dart';
import 'package:scheduler/models/Reservation.dart';
import 'package:scheduler/repository/ReservationRepsitory.dart';

class ReservationManagerBloc extends ChangeNotifier {
  ReservationReopsitory _reservationReopsitory = ReservationRepositoryImpl();
  List<Reservation> allReservations = [];
  List<Reservation> userReservation = [];
  List<int> reservedHours = [];
  bool isLoading = false;

  Future<bool> postReservation(Reservation reservation) async {
    isLoading = true;
    bool result = await _reservationReopsitory.createReservation(reservation);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future loadAllReservations() async {
    isLoading = true;
    allReservations = await _reservationReopsitory.getAllReservations();
    isLoading = false;
    notifyListeners();
  }

  Future loadUserReservations(String userId) async {
    isLoading = true;
    userReservation = await _reservationReopsitory.getUserReservations(userId);
    isLoading = false;
    notifyListeners();
  }

  Future loadReservedHours(String date) async {
    reservedHours.clear();
    isLoading = true;
    var _list = await _reservationReopsitory.getReservedHours(date);
    _list.map((e) => e.slotsReserved.forEach((element) {
          reservedHours.add(element);
        }));
    isLoading = false;
    notifyListeners();
  }
}
