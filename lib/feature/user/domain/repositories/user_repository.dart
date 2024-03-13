import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(
    int limit, {
    bool? clear,
  });

  Future<User> addUpdateUser(User user);
  Future<int?> deleteUser(User user);
}
