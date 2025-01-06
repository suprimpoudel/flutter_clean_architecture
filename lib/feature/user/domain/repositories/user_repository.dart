import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';

mixin UserRepository {
  Future<List<User>> getUsers(
    int limit,
    int offset,
  );

  Future<User> addUpdateUser(User user);

  Future<User> getUserById(int? userId);

  Future<void> deleteUser(User user);
}
