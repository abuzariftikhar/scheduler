import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:uuid/uuid.dart';

abstract class ServiceReopsitory {
  final String servicesPath = "services";

  Future<List<ServiceItem>> getAllservices(String userId);
  Future<List<ServiceItem>> getServicesbyType(String type);
  Future<List<ServiceItem>> getServicesbyCategory(String category);
  Future<bool> createService(ServiceItem serviceModel);
  Future<bool> updateService(ServiceItem serviceModel);
  Future<bool> deleteService(ServiceItem serviceModel);
}

class ServiceRepositoryImpl extends ServiceReopsitory {
  @override
  Future<List<ServiceItem>> getServicesbyType(String type) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(servicesPath)
        .where("type", isEqualTo: type)
        .get();
    var _list = querySnapshot.docs
        .map((DocumentSnapshot doc) => ServiceItem.fromMap(doc.data()as Map<String, dynamic>))
        .toList();
    return _list;
  }

  @override
  Future<List<ServiceItem>> getServicesbyCategory(String category) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(servicesPath)
        .where("category", isEqualTo: category)
        .get();
    var _list = querySnapshot.docs
        .map((DocumentSnapshot doc) => ServiceItem.fromMap(doc.data()as Map<String, dynamic>))
        .toList();
    return _list;
  }

  @override
  Future<List<ServiceItem>> getAllservices(String userId) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(servicesPath).get();
    var list = querySnapshot.docs
        .map((DocumentSnapshot doc) => ServiceItem.fromMap(doc.data()as Map<String, dynamic>))
        .toList();
    return list;
  }

  @override
  Future<bool> createService(ServiceItem serviceModel) async {
    var uuid = Uuid();
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(servicesPath);
      var id = uuid.v4().toString();
      serviceModel.id = id;
      await reference.doc(id).set(serviceModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateService(ServiceItem serviceModel) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(servicesPath);
      await reference.doc(serviceModel.id).update(serviceModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteService(ServiceItem serviceModel) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(servicesPath);
      await reference.doc(serviceModel.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
