import 'package:flutter_clean_architecture/common/utilities/constants/database_constants.dart';
import 'package:flutter_clean_architecture/common/utilities/helpers/db_helper.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';

class UserDataSource {
  final DBHelper _dbHelper;

  UserDataSource(this._dbHelper);

  Future<List<User>> getUsers(int limit, int offset) async =>
      await _getUserList(limit: limit, offset: offset).then((value) {
        return value;
      });

  Future<int?> addUpdateUser(User userObject) async =>
      await _dbHelper.insertEntity(
        user,
        userObject,
      );

  Future<void> deleteUser(User userObject) async =>
      await _dbHelper.delete(tableName: user, where: '$id = ?', whereArgs: [
        userObject.id,
      ]);

  Future<User> getUserById(int? userId) async =>
      await _dbHelper.getSingle<User>(
        user,
        (value) => User.fromMap(value),
        "$id = ?",
        [
          userId,
        ],
      );

  Future<List<User>> _getUserList({
    int? limit,
    int? offset,
    String? where,
    List<dynamic>? whereArgs,
  }) async =>
      await _dbHelper.getList<User>(
        user,
        (value) => User.fromMap(value),
        whereArgs: whereArgs,
        where: where,
        orderBy: '$id DESC',
        offset: offset,
        limit: limit,
      );
}
