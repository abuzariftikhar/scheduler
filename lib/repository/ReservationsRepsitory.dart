import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/models/Reservation.dart';
import 'package:uuid/uuid.dart';

abstract class ReservationReopsitory {
  final String reservationPath = "reservations";

  Future<List<Reservation>> getAllReservations();
  Future<List<Reservation>> getUserReservations(String userId);
  Future<List<Reservation>> getReservationsByDate(String date);
  Future<bool> createReservation(Reservation reservation);
}

class ReservationRepositoryImpl extends ReservationReopsitory {
  @override
  Future<bool> createReservation(Reservation reservation) async {
    var uuid = Uuid();
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(reservationPath);
      var id = uuid.v4().toString();
      reservation.id = id;
      await reference.doc(id).set(reservation.toMap());
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
}
