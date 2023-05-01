import 'package:flutter_seoul/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

/// NotifierProvider
@riverpod
class UserState extends _$UserState {
  @override
  UserModel? build() {
    return null;
  }

  void addUsers({
    required UserModel user,
  }) {
    state = user;
  }

  void remove() {
    state = null;
  }
}
