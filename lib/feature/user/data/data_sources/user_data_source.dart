import 'package:flutter_clean_architecture/common/utilities/constants/database_constants.dart';
import 'package:flutter_clean_architecture/common/utilities/helpers/db_helper.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDataSource {
  final DBHelper _dbHelper;

  UserDataSource(this._dbHelper);

  int _offset = 0;

  Future<List<User>> getUsers(int limit) async {
    return await _getUserList(limit: limit, offset: _offset).then((value) {
      _offset += limit;
      return value;
    });
  }

  Future<User> addUpdateUser(User userObject) async {
    var database = await _dbHelper.getDatabaseObject;
    return await database
        .insert(
      user,
      userObject.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .then((value) {
      return userObject.copyWith(
        id: value,
      );
    });
  }

  Future<int?> deleteUser(User userObject) async {
    return await _dbHelper
        .delete(tableName: user, where: '$id = ?', whereArgs: [
      userObject.id,
    ]).then((value) {
      return userObject.id;
    });
  }

  Future<List<User>> _getUserList({
    int? limit,
    int? offset,
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await _dbHelper
        .queryGet(
      tableName: user,
      whereArgs: whereArgs,
      where: where,
      orderBy: '$id DESC',
      offset: offset,
      limit: limit,
    )
        .then((valueMap) {
      int count = valueMap?.length ?? 0;

      List<User> valueList = [];
      if (valueMap != null) {
        for (int i = 0; i < count; i++) {
          valueList.add(User.fromMap(valueMap[i]));
        }
      }
      return valueList;
    });
  }

  void clear() {
    _offset = 0;
  }
}
