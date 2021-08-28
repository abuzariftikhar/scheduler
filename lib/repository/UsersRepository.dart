import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/models/UserModel.dart';

abstract class UsersRepository {
  final String path = "users";

  Future<UserModel> getCurrentUser(String userID);
  Future<bool> createUser(UserModel user);
  Future<bool> updateUser(UserModel user);
  Future<bool> deleteUser(UserModel user);
}

class UsersRepositoryImpl extends UsersRepository {
  @override
  Future<bool> createUser(UserModel user) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection(path);
      await reference.doc(user.userID).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel> getCurrentUser(String userID) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection(path).doc(userID).get();
    var _user =
        UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return _user;
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection(path)
          .doc(user.userID)
          .update(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection(path)
          .doc(user.userID)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
