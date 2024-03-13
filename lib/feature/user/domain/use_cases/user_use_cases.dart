import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/common/utilities/constants/regex_constants.dart';
import 'package:flutter_clean_architecture/common/utilities/helpers/regex_helper.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';

abstract class UserUseCases extends Equatable {
  const UserUseCases();

  @override
  List<Object?> get props => [];
}

class ClearAndFetchUserCase extends UserUseCases {}

class LoadMoreUserCase extends UserUseCases {}

class AddUpdateUserCase extends UserUseCases {
  final User user;

  const AddUpdateUserCase(this.user);

  void validate() {
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

class DeleteUserCase extends UserUseCases {
  final User user;

  const DeleteUserCase(this.user);

  void validate() {
    if (user.id == null) {
      throw Exception("User id is null");
    }
  }
}
