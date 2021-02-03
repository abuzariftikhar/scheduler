import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/models/Reservation.dart';
import 'package:scheduler/models/Timeline.dart';
import 'package:uuid/uuid.dart';

abstract class ReservationReopsitory {
  final String reservationPath = "reservations";
  final String timlinePath = "timeline";

  Future<List<Reservation>> getAllReservations();
  Future<List<Reservation>> getUserReservations(String userId);
  Future<List<Reservation>> getReservationsByDate(String date);
  Future<bool> createReservation(Reservation reservation);
  Future<bool> createReservedHours(Timeline timeline);
  Future<List<Timeline>> getReservedHours(String date);
}

class ReservationRepositoryImpl extends ReservationReopsitory {
  @override
  Future<bool> createReservation(Reservation reservation) async {
    var uuid = Uuid();
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(reservationPath);
      reservation.id = uuid.v4().toString();
      await reference.add(reservation.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Reservation>> getUserReservations(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(reservationPath)
        .where("userId", isEqualTo: userId)
        .get();
    var _list = querySnapshot.docs
        .map((DocumentSnapshot doc) => Reservation.fromMap(doc.data()))
        .toList();
    return _list;
  }

  @override
  Future<List<Reservation>> getAllReservations() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(reservationPath).get();
    var _list = querySnapshot.docs
        .map((DocumentSnapshot doc) => Reservation.fromMap(doc.data()))
        .toList();
    return _list;
  }

  @override
  Future<List<Reservation>> getReservationsByDate(String date) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(reservationPath)
        .where("date", isEqualTo: date)
        .get();
    var _list = querySnapshot.docs
        .map((DocumentSnapshot doc) => Reservation.fromMap(doc.data()))
        .toList();
    return _list;
  }

  Future<bool> createReservedHours(Timeline timeline) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(timlinePath);
      reference.add(timeline.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Timeline>> getReservedHours(String date) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(timlinePath)
        .where("date", isEqualTo: date)
        .get();
    var _list = querySnapshot.docs
        .map((DocumentSnapshot doc) => Timeline.fromMap(doc.data()))
        .toList();
    return _list;
  }
}
