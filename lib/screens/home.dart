import 'dart:math';

import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/models/item_model.dart';
import 'package:flutter_seoul/repositories/item_repository.dart';
import 'package:flutter_seoul/utils/general.dart';
import 'package:flutter_seoul/widgets/common/button.dart';
import 'package:flutter_seoul/widgets/common/edit_text.dart';
import 'package:flutter_seoul/widgets/common/styles.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var itemData =
        useState<ItemModel>(const ItemModel(id: 0, title: '', content: ''));
    var itemList = useState<List<ItemModel>>([]);

    useEffect(() {
      Future<void> init() async {
        var result = await ItemRepository.instance.getItems();
        itemList.value = result;
      }

      init();
      return null;
    }, []);

    Future<void> addItem() async {
      if (!formKey.currentState!.validate()) return;

      var rng = Random();
      var rngId = rng.nextInt(100);
      await ItemRepository.instance
          .addItem(item: itemData.value.copyWith(id: rngId));
      if (context.mounted) {
        itemList.value = [
          ...itemList.value,
          itemData.value.copyWith(id: rngId)
        ];
        Navigator.pop(context);
      }
    }

    Future<void> removeItem(int id) async {
      await ItemRepository.instance.removeItem(id: id);
      itemList.value =
          itemList.value.where((element) => element.id != id).toList();
    }

    Future<void> updateItem(int id) async {
      await ItemRepository.instance
          .updateItem(item: itemData.value.copyWith(id: id));
      if (context.mounted) {
        itemList.value = itemList.value
            .map((e) => e.id == id ? itemData.value.copyWith(id: id) : e)
            .toList();
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FlatList<ItemModel>(
        data: itemList.value,
        buildItem: (item, index) {
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
                              initialValue: item.title,
                              margin: const EdgeInsets.only(top: 20),
                              label: 'Title',
                              hintText: 'Title',
                              onChanged: (val) {
                                itemData.value =
                                    itemData.value.copyWith(title: val);
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
                              initialValue: item.content,
                              margin: const EdgeInsets.only(top: 20),
                              label: 'Content',
                              hintText: 'Content',
                              onChanged: (val) {
                                itemData.value =
                                    itemData.value.copyWith(content: val);
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
                              onPress: () => updateItem(item.id),
                              text: '업데이트',
                            )
                          ],
                        ),
                      ),
                    ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'title: ${item.title}',
                            style: const TitleTextStyle(),
                          ),
                          Text('content: ${item.content}',
                              style: const SubTitleTextStyle())
                        ],
                      ),
                      IconButton(
                        onPressed: () => removeItem(item.id),
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
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
