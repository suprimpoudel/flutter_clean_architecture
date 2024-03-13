import 'dart:async';
import 'dart:io';

import 'package:flutter_clean_architecture/common/utilities/constants/database_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper? _databaseHelper;
  static Database? _database;

  DBHelper._createInstance();

  factory DBHelper() {
    _databaseHelper ??= DBHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get getDatabaseObject async {
    return _database ?? await init();
  }

  Future<Database> init({Database? db}) async {
    if (db != null) {
      _database = db;
      return db;
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}/$dbName';
      return await openDatabase(path,
          version: 2, onCreate: _createDb, onUpgrade: _onUpgrade);
    }
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.transaction((txn) async {
      await txn.execute(
          'CREATE TABLE IF NOT EXISTS $user($id INTEGER PRIMARY KEY AUTOINCREMENT, $firstName TEXT, $lastName TEXT, $emailAddress TEXT, $phoneNumber TEXT)');
    });
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    var difference = newVersion - oldVersion;
    if (newVersion > oldVersion) {
      if (difference == 1) {
        await _performUpgrade(db, newVersion);
      } else {
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          await _performUpgrade(db, i);
        }
      }
    }
  }

  Future<void> _performUpgrade(Database db, int version) async {
    switch (version) {
      case 2:
        await db.rawQuery("ALTER TABLE $user ADD COLUMN $lastName TEXT");
      default:
        // Handle unknown versions or future versions gracefully
        break;
    }
  }

  Future<List<Map<String, dynamic>>?> queryGet({
    required String tableName,
    String? orderBy,
    String? where,
    int? limit,
    int? offset,
    List<dynamic>? whereArgs,
  }) async {
    var db = await getDatabaseObject;

    return await db.transaction((txn) async {
      if (whereArgs == null || where == null) {
        if (orderBy == null) {
          return limit == null
              ? await txn.query(tableName)
              : await txn.query(tableName, limit: limit, offset: offset);
        } else {
          return limit == null
              ? await txn.query(tableName, orderBy: orderBy)
              : await txn.query(tableName,
                  orderBy: orderBy, limit: limit, offset: offset);
        }
      } else {
        if (orderBy == null) {
          return limit == null
              ? await txn.query(
                  tableName,
                  where: where,
                  whereArgs: whereArgs,
                )
              : await txn.query(
                  tableName,
                  where: where,
                  limit: limit,
                  offset: offset,
                  whereArgs: whereArgs,
                );
        } else {
          return limit == null
              ? await txn.query(
                  tableName,
                  orderBy: orderBy,
                  where: where,
                  whereArgs: whereArgs,
                )
              : await txn.query(
                  tableName,
                  orderBy: orderBy,
                  limit: limit,
                  offset: offset,
                  where: where,
                  whereArgs: whereArgs,
                );
        }
      }
    });
  }

  Future<int?> delete({
    required String tableName,
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await getDatabaseObject.then((db) async {
      if (whereArgs == null || where == null) {
        return await db.delete(tableName);
      } else {
        return await db.delete(
          tableName,
          where: where,
          whereArgs: whereArgs,
        );
      }
    });
  }

  Future<void> closeDatabase() async {
    await getDatabaseObject.then((value) {
      value.close();
    });
  }
}
