import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate/errors/user_not_found.dart';
import 'package:flutter_boilerplate/models/user_model.dart';
import 'package:flutter_boilerplate/services/firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();
  final Rxn<UserModel> _user = Rxn<UserModel>();
  final _firestore = Firestore();

  set user(UserModel user) => _user.value = user;

  UserModel get user {
    if (_user.value == null) {
      throw UserNotFound("User model not found.");
    }

    return _user.value!;
  }

  User get authUser {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw UserNotFound("Firebase auth user not found.");
    }

    return FirebaseAuth.instance.currentUser!;
  }

  Future<void> initUser() async {
    final userModel = await _firestore.getUser(authUser.uid);

    if (userModel == null) {
      throw UserNotFound("Firestore user not found.");
    }

    user = userModel;
  }

  Future<void> storeUser(UserModel user) => _firestore.storeUser(user);

  Future<List<UserModel>> searchUsersByName(query) =>
      _firestore.searchUserByName(query);

  Future<void> storeFavoriteUser(String id) => _firestore.storeFavoriteUser(id);
}
