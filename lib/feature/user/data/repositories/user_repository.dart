import 'package:flutter_clean_architecture/feature/user/data/data_sources/user_data_source.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';
import 'package:flutter_clean_architecture/feature/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<List<User>> getUsers(
    int limit, {
    bool? clear,
  }) async {
    if (clear == true) {
      _dataSource.clear();
    }
    try {
      return await _dataSource.getUsers(limit);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<User> addUpdateUser(User user) async {
    try {
      return await _dataSource.addUpdateUser(user);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<int?> deleteUser(User user) async {
    try {
      return await _dataSource.deleteUser(user);
    } catch (_) {
      rethrow;
    }
  }
}
