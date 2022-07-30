import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_boilerplate/models/user_model.dart';

class FirestoreReference {
  final _db = FirebaseFirestore.instance;

  CollectionReference<UserModel> getUserCollection() {
    return _db.collection("users").withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  DocumentReference getUserDoc(String id) => getUserCollection().doc(id);
}
