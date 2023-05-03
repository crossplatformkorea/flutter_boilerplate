import 'dart:math';

import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/models/item_model.dart';
import 'package:flutter_seoul/providers/item_provider.dart';
import 'package:flutter_seoul/utils/general.dart';
import 'package:flutter_seoul/utils/router_config.dart';
import 'package:flutter_seoul/widgets/common/button.dart';
import 'package:flutter_seoul/widgets/common/edit_text.dart';
import 'package:flutter_seoul/widgets/common/loading_indicator.dart';
import 'package:flutter_seoul/widgets/common/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var itemData =
        useState<ItemModel>(const ItemModel(id: 0, title: '', content: ''));
    final itemNotifier = ref.watch(asyncItemsProvider.notifier);
    final itemAsync = ref.watch(asyncItemsProvider);

    Future<void> addItem() async {
      if (!formKey.currentState!.validate()) return;

      var rng = Random();
      var rngId = rng.nextInt(100);

      itemNotifier.addItems(item: itemData.value.copyWith(id: rngId));
      Navigator.pop(context);
    }

    Future<void> removeItem(int id) async {
      itemNotifier.removeItems(id: id);
    }

    Future<void> updateItem(int id) async {
      itemNotifier.updateItems(item: itemData.value.copyWith(id: id));
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: itemAsync.when(
        error: (e, st) => Text(e.toString()),
        loading: () => const LoadingIndicator(),
        data: (item) => FlatList<ItemModel>(
          onRefresh: () => itemNotifier.fetchItem(),
          data: item,
          buildItem: (buildItem, index) {
            return Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: InkWell(
                onTap: () {
                  context.push(
                    '${GoRoutes.home.fullPath}/${buildItem.id}',
                    extra: buildItem,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'title: ${buildItem.title}',
                            style: const TitleTextStyle(),
                          ),
                          Text('content: ${buildItem.content}',
                              style: const SubTitleTextStyle())
                        ],
                      ),
                      Wrap(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => General.instance.showBottomSheet(
                                context,
                                Form(
                                  key: formKey,
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        EditFormText(
                                          initialValue: buildItem.title,
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          label: 'Title',
                                          hintText: 'Title',
                                          onChanged: (val) {
                                            itemData.value = itemData.value
                                                .copyWith(title: val);
                                          },
                                          validator: (_) {
                                            var text = itemData.value.title;
                                            if (text.isEmpty) {
                                              return '제목을 입력해주세요';
                                            }
                                            return null;
                                          },
                                        ),
                                        EditFormText(
                                          initialValue: buildItem.content,
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          label: 'Content',
                                          hintText: 'Content',
                                          onChanged: (val) {
                                            itemData.value = itemData.value
                                                .copyWith(content: val);
                                          },
                                          validator: (_) {
                                            var text = itemData.value.content;
                                            if (text.isEmpty) {
                                              return '내용을 입력해주세요';
                                            }
                                            return null;
                                          },
                                        ),
                                        Button(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          onPress: () =>
                                              updateItem(buildItem.id),
                                          text: '업데이트',
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => removeItem(buildItem.id),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          General.instance.showBottomSheet(
            context,
            Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    EditFormText(
                      margin: const EdgeInsets.only(top: 20),
                      label: 'Title',
                      hintText: 'Title',
                      onChanged: (val) {
                        itemData.value = itemData.value.copyWith(title: val);
                      },
                      validator: (_) {
                        var text = itemData.value.title;
                        if (text.isEmpty) {
                          return '제목을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    EditFormText(
                      margin: const EdgeInsets.only(top: 20),
                      label: 'Content',
                      hintText: 'Content',
                      onChanged: (val) {
                        itemData.value = itemData.value.copyWith(content: val);
                      },
                      validator: (_) {
                        var text = itemData.value.content;
                        if (text.isEmpty) {
                          return '내용을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    Button(
                      margin: const EdgeInsets.only(top: 20),
                      onPress: addItem,
                      text: '추가',
                    )
                  ],
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
