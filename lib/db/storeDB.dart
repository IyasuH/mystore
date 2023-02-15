// now as database helper file for account
// without the use model file

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class myStoreDatabaseHelper {
  static const _dbName = 'myStore.db';
  static const _dbVersion = 1;
  static const _accounTableName = 'account';

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);
    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_accounTableName(
      _id INTEGER PRIMARY KEY AUTOINCREMENT,
      bankName TEXT NOT NULL,
      accountNumber INTEGER NOT NULL,
      amount INTEGER NOT NULL,
      accountCreatedDate TEXT NOT NULL)
      ''');
  }

  Future<int> insertAccount(Map<String, dynamic> row) async {
    return await _db.insert(_accounTableName, row);
  }

  Future<List<Map>> queryAllAccount() async =>
      await _db.query(_accounTableName);

  Future updateAccount(Map<String, dynamic> row) async {
    int id = row['_id'];
    return await _db
        .update(_accounTableName, row, where: '_id = ?', whereArgs: [id]);
  }

  Future<int> deleteAccount(int id) async {
    return await _db
        .delete(_accounTableName, where: '_id = ?', whereArgs: [id]);
  }
}
