import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/common/di/app_module.dart';
import 'package:flutter_clean_architecture/feature/user/domain/entities/user_state.dart';
import 'package:flutter_clean_architecture/feature/user/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/feature/user/domain/use_cases/user_use_cases.dart';

class UserBloc extends Bloc<UserUseCases, UserState> {
  final _limit = 20;

  bool _noMoreData = false;

  UserBloc() : super(UserIdleState()) {
    var repository = locator.get<UserRepository>();
    on<ClearAndFetchUserCase>((event, emit) async {
      _noMoreData = false;
      emit(UserClearState());
      emit(UserListLoadingState());
      await repository.getUsers(_limit, clear: true).then((value) {
        if (value.length < _limit) {
          _noMoreData = true;
        }
        emit(UserDataFetchedState(value));
      }).catchError((onError) {
        emit(UserListErrorState(onError));
      });
    });
    on<LoadMoreUserCase>((event, emit) async {
      if (_noMoreData) {
        emit(UserIdleState());
        return;
      }

      emit(UserPaginationLoadingState());
      await repository
          .getUsers(
        _limit,
      )
          .then((value) {
        if (value.length < _limit) {
          _noMoreData = true;
        }
        emit(UserDataFetchedState(value));
      }).catchError((onError) {
        emit(UserListErrorState(onError));
      });
    });
    on<AddUpdateUserCase>((event, emit) async {
      emit(UserLoadingState());
      try {
        event.validate();
        await repository.addUpdateUser(event.user).then((value) {
          if (event.user.id == null) {
            emit(UserAddState(value));
          } else {
            emit(UserUpdateState(value));
          }
        });
      } catch (e) {
        emit(UserErrorState(e));
      }
    });
    on<DeleteUserCase>((event, emit) async {
      emit(UserListLoadingState());
      try {
        event.validate();
        await repository.deleteUser(event.user).then((value) {
          emit(UserDeleteState(value));
        });
      } catch (e) {
        emit(UserListErrorState(e));
      }
    });
  }
}
