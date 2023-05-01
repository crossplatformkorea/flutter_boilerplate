import 'dart:async';

import 'package:flutter_seoul/models/item_model.dart';
import 'package:flutter_seoul/repositories/item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_provider.g.dart';

/// AsyncNotifierProvider
// @Riverpod(keepAlive: true)
@riverpod
class AsyncItems extends _$AsyncItems {
  Future<List<ItemModel>> fetchItem() async {
    // get the [KeepAliveLink]
    final link = ref.keepAlive();
    // a timer to be used by the callbacks below
    Timer? timer;
    // An object from package:dio that allows cancelling http requests
    // When the provider is destroyed, cancel the http request and the timer
    ref.onDispose(() {
      timer?.cancel();
    });
    // When the last listener is removed, start a timer to dispose the cached data
    ref.onCancel(() {
      // start a 30 second timer
      timer = Timer(const Duration(seconds: 30), () {
        // dispose on timeout
        link.close();
      });
    });
    // If the provider is listened again after it was paused, cancel the timer
    ref.onResume(() {
      timer?.cancel();
    });

    final itemData = ItemRepository.instance.getItems();
    return itemData;
  }

  @override
  Future<List<ItemModel>> build() async {
    return fetchItem();
  }

  Future<void> addItems({
    required ItemModel item,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      ItemRepository.instance.addItem(item: item);
      return fetchItem();
    });
  }

  Future<void> removeItems({
    required int id,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      ItemRepository.instance.removeItem(id: id);
      return fetchItem();
    });
  }

  Future<void> updateItems({
    required ItemModel item,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      ItemRepository.instance.updateItem(item: item);
      return fetchItem();
    });
  }
}
