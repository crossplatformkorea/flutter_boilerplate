import 'package:flutter_seoul/models/user_model.dart';
import 'package:flutter_seoul/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserState extends _$UserState {
  Future<List<UserModel>?> fetchUser() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await UserRepository.instance.getMe();
    });
    return state.value;
  }

  @override
  Future<List<UserModel>?> build() async {
    return fetchUser();
  }

  Future<void> removeUser() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return null;
    });
  }
}
