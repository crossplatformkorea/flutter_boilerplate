import 'package:flutter_seoul/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class IUserRepository {
  Future<void> login(UserModel user);
  Future<void> logout();
  Future<Database> initDB();
  Future<List<Map<String, dynamic>>> getMe();
}

class UserRepository implements IUserRepository {
  const UserRepository._();
  static UserRepository instance = const UserRepository._();

  @override
  Future<Database> initDB() async {
    final Future<Database> database = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'doggie_database.db'),

      onCreate: (db, version) {
        // 데이터베이스에 CREATE TABLE 수행
        return db.execute(
          'CREATE TABLE user(id TEXT PRIMARY KEY ,email TEXT, password TEXT)',
        );
      },
      version: 1,
    );

    final Database db = await database;
    return db;
  }

  @override
  Future<void> login(UserModel user) async {
    final Database db = await initDB();

    db.insert('user', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> logout() async {}

  @override
  Future<List<Map<String, dynamic>>> getMe() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('user');

    return maps;
  }
}
