import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(
    int limit,
    bool? clear,
  );

  Future<User> addUpdateUser(User user);
  Future<User> getUserById(int? userId);
  Future<int?> deleteUser(User user);
}
