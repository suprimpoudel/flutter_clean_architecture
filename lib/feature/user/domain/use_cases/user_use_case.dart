import 'package:flutter_clean_architecture/common/utilities/constants/regex_constants.dart';
import 'package:flutter_clean_architecture/common/utilities/helpers/regex_helper.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';
import 'package:flutter_clean_architecture/feature/user/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository _repository;

  UserUseCase(this._repository);

  Future<List<User>> getUsers(
    int limit, {
    bool? clear,
  }) async =>
      await _repository.getUsers(limit, clear);

  Future<User> addUpdateUser(User user) async {
    _validate(user);
    return await _repository.addUpdateUser(user);
  }

  Future<int?> deleteUser(User user) async {
    if (user.id == null) {
      throw Exception("User id is null");
    }

    return await _repository.deleteUser(user);
  }

  void _validate(User user) {
    var firstName = user.firstName ?? "";
    var lastName = user.lastName ?? "";
    var email = user.emailAddress ?? "";
    var phone = user.phoneNumber ?? "";

    if (firstName.isEmpty) {
      throw Exception("First name is required");
    } else if (lastName.isEmpty) {
      throw Exception("Last name is required");
    } else if (email.isEmpty) {
      throw Exception("Email Address is required");
    } else if (phone.isEmpty) {
      throw Exception("Phone Number is required");
    } else if (!validateRegex(firstName, namePattern)) {
      throw Exception("Invalid first name");
    } else if (!validateRegex(lastName, namePattern)) {
      throw Exception("Invalid last name");
    } else if (!validateRegex(email, emailPattern)) {
      throw Exception("Invalid email");
    } else if (!validateRegex(phone, phoneNumberPattern)) {
      throw Exception("Invalid phone");
    }
  }
}
