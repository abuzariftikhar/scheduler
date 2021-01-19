import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/models/ServiceModel.dart';

abstract class ServiceReopsitory {
  final String servicesPath = "services";

  Future<List<ServiceModel>> getAllservices(String userId);
  Future<List<ServiceModel>> getServicesbyType(String type);
  Future<bool> createService(ServiceModel serviceModel);
  // Future<ServiceModel> updateService(ServiceModel serviceModel);
}

class ServiceRepositoryImpl extends ServiceReopsitory {
  @override
  Future<bool> createService(ServiceModel serviceModel) async {
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
  Future<List<ServiceModel>> getServicesbyType(String type) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(servicesPath)
        .where("type", isEqualTo: type)
        .get();
    var list = querySnapshot.docs
        .map((DocumentSnapshot doc) => ServiceModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  @override
  Future<List<ServiceModel>> getAllservices(String userId) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(servicesPath).get();
    var list = querySnapshot.docs
        .map((DocumentSnapshot doc) => ServiceModel.fromMap(doc.data()))
        .toList();
    return list;
  }
}
