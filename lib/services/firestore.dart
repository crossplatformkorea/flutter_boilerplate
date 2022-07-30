import 'package:flutter_boilerplate/models/user_model.dart';

import 'firestore_reference.dart';

class Firestore {
  FirestoreReference ref = FirestoreReference();

  Future<void> storeUser(UserModel user) =>
      ref.getUserCollection().doc(user.id).set(user);

  Future<UserModel?> getUser(String userId) async {
    final snapshot = await ref.getUserCollection().doc(userId).get();

    return snapshot.data();
  }

  Future<List<UserModel>> searchUserByName(String query) async {
    final snapshot = await ref
        .getUserCollection()
        .orderBy("name")
        .startAt([query]).endAt(["$query\uf8ff"]).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> storeFavoriteUser(String id) async {
    //
  }
}
