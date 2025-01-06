import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class ClearAndFetchEvent extends UserEvent {}

class LoadMoreEvent extends UserEvent {}

class AddUpdateEvent extends UserEvent {
  final User _user;

  User get user => _user;

  const AddUpdateEvent(this._user);

  @override
  List<Object?> get props => [
    _user,
  ];
}

class DeleteUserEvent extends UserEvent {
  final User _user;

  User get user => _user;

  const DeleteUserEvent(this._user);

  @override
  List<Object?> get props => [
    _user,
  ];
}
