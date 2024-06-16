import 'package:equatable/equatable.dart';
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
}

class DeleteUserCase extends UserUseCases {
  final User user;

  const DeleteUserCase(this.user);
}
