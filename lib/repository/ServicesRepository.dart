import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/models/ServiceModel.dart';

abstract class ServiceReopsitory {
  final String servicesPath = "services";

  Future<List<ServiceItem>> getAllservices(String userId);
  Future<List<ServiceItem>> getServicesbyType(String type);
  Future<List<ServiceItem>> getServicesbyCategory(String category);
  Future<bool> createService(ServiceItem serviceModel);
  // Future<ServiceModel> updateService(ServiceModel serviceModel);
}

class ServiceRepositoryImpl extends ServiceReopsitory {
  @override
  Future<bool> createService(ServiceItem serviceModel) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(servicesPath);
      serviceModel.id = reference.id;
      await reference.add(serviceModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ServiceItem>> getServicesbyType(String type) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(servicesPath)
        .where("type", isEqualTo: type)
        .get();
    var _list = querySnapshot.docs
        .map((DocumentSnapshot doc) => ServiceItem.fromMap(doc.data()))
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
        .map((DocumentSnapshot doc) => ServiceItem.fromMap(doc.data()))
        .toList();
    return _list;
  }

  @override
  Future<List<ServiceItem>> getAllservices(String userId) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(servicesPath).get();
    var list = querySnapshot.docs
        .map((DocumentSnapshot doc) => ServiceItem.fromMap(doc.data()))
        .toList();
    return list;
  }
}
