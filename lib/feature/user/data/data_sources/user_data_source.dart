import 'package:flutter_clean_architecture/common/utilities/constants/database_constants.dart';
import 'package:flutter_clean_architecture/common/utilities/helpers/db_helper.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';

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
    return await _dbHelper
        .insertEntity(
      user,
      userObject,
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

  Future<User> getUserById(int? userId) async {
    return await _dbHelper.getSingle<User>(
      user,
      (value) => User.fromMap(value),
      "$id = ?",
      [
        userId,
      ],
    );
  }

  Future<List<User>> _getUserList({
    int? limit,
    int? offset,
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await _dbHelper.getList<User>(
      user,
      (value) => User.fromMap(value),
      whereArgs: whereArgs,
      where: where,
      orderBy: '$id DESC',
      offset: offset,
      limit: limit,
    );
  }

  void clear() {
    _offset = 0;
  }
}
