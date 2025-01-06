import 'package:flutter_clean_architecture/feature/user/data/data_sources/user_data_source.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';
import 'package:flutter_clean_architecture/feature/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<List<User>> getUsers(
    int limit,
    int offset,
  ) async =>
      await _dataSource.getUsers(limit, offset);

  @override
  Future<User> addUpdateUser(User user) async {
    var result = await _dataSource.addUpdateUser(user);
    return user.copyWith(
      id: result,
    );
  }

  @override
  Future<void> deleteUser(User user) async =>
      await _dataSource.deleteUser(user);

  @override
  Future<User> getUserById(int? userId) async =>
      await _dataSource.getUserById(userId);
}
