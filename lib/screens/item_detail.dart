import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/models/item_model.dart';
import 'package:flutter_seoul/widgets/common/app_bar.dart';

class ItemDetail extends HookWidget {
  const ItemDetail({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(
        title: Text(item.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.content, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
