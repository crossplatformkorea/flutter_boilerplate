import 'package:flutter/material.dart';
import 'package:flutter_seoul/models/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserState extends ChangeNotifier {
  final List<UserModel> _users = [];

  List<UserModel> get users => _users;

  void addUsers({
    required UserModel user,
  }) {
    _users.add(user);

    notifyListeners();
  }

  void remove() {
    _users.clear();
    notifyListeners();
  }
}

final userProvider = ChangeNotifierProvider<UserState>((ref) {
  return UserState();
});
