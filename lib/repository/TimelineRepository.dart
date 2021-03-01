import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/models/Timeline.dart';
import 'package:uuid/uuid.dart';

abstract class TimelineRepository {
  final String path = "timeline";

  Future<List<Timeline>> getOccupiedTimelinesByDate(DateTime dateTime);
  Future<bool> createTimeline(Timeline timeline);
  Future<bool> updateTimeline(Timeline timeline);
  Future<bool> deleteTimeline(Timeline timeline);
}

class TimelineRepositoryImpl extends TimelineRepository {
  @override
  Future<bool> createTimeline(Timeline timeline) async {
    var uuid = Uuid();
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(path);
      var id = uuid.v4().toString();
      await reference.doc(id).set(timeline.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTimeline(Timeline timeline) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(path);
      await reference.doc(timeline.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Timeline>> getOccupiedTimelinesByDate(DateTime date) async {
    CollectionReference reference = FirebaseFirestore.instance.collection(path);
    QuerySnapshot querySnapshot =
        await reference.where("date", isEqualTo: date).get();
    var _list = querySnapshot.docs.map((item) => Timeline.fromMap(item.data()));
    return _list;
  }

  @override
  Future<bool> updateTimeline(Timeline timeline) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(path);
      await reference.doc(timeline.id).update(timeline.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
