import 'package:flutter_seoul/models/item_model.dart';
import 'package:flutter_seoul/utils/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class IItemRepository {
  Future<Database> initDB();
  Future<void> addItem({required ItemModel item});
  Future<void> removeItem();
  Future<void> updateItem();
  Future<List<ItemModel>> getItems();
}

class ItemRepository implements IItemRepository {
  const ItemRepository._();
  static ItemRepository instance = const ItemRepository._();

  @override
  Future<Database> initDB() async {
    final Future<Database> database = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'item_database.db'),

      onCreate: (db, version) {
        // 데이터베이스에 CREATE TABLE 수행
        return db.execute(
          'CREATE TABLE item(id INTEGER PRIMARY KEY ,title TEXT, content TEXT)',
        );
      },
      version: 1,
    );

    final Database db = await database;
    return db;
  }

  @override
  Future<void> addItem({required ItemModel item}) async {
    print('item:$item');
    final Database db = await initDB();
    try {
      db.insert('item', item.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  Future<void> removeItem() async {
    final Database db = await initDB();
    db.delete('item');
  }

  @override
  Future<void> updateItem() async {
    final Database db = await initDB();
    db.delete('item');
  }

  @override
  Future<List<ItemModel>> getItems() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('item');

    return List.generate(maps.length, (i) {
      return ItemModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }
}