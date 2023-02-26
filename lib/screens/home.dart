import 'dart:math';

import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/models/item_model.dart';
import 'package:flutter_seoul/repositories/item_repository.dart';
import 'package:flutter_seoul/utils/general.dart';
import 'package:flutter_seoul/widgets/common/button.dart';
import 'package:flutter_seoul/widgets/common/styles.dart';
import 'package:flutter_seoul/widgets/edit_text.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var item =
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

    Future<void> addContent() async {
      if (!formKey.currentState!.validate()) return;

      var rng = Random();

      await ItemRepository.instance
          .addItem(item: item.value.copyWith(id: rng.nextInt(100)));
      if (context.mounted) {
        itemList.value = [...itemList.value, item.value];
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
                  // todo go to detail
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'title: ${item.title}',
                        style: const TitleTextStyle(),
                      ),
                      Text('content: ${item.content}',
                          style: const SubTitleTextStyle())
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
                        item.value = item.value.copyWith(title: val);
                      },
                      validator: (_) {
                        var text = item.value.title;
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
                        item.value = item.value.copyWith(content: val);
                      },
                      validator: (_) {
                        var text = item.value.content;
                        if (text.isEmpty) {
                          return '내용을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    Button(
                      margin: const EdgeInsets.only(top: 20),
                      onPress: addContent,
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
