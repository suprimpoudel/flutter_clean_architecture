import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/feature/user/domain/use_cases/user_use_case.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_state.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _limit = 20;

  bool _noMoreData = false;

  final UserUseCase _useCase;

  UserBloc(this._useCase) : super(UserIdleState()) {
    on<ClearAndFetchEvent>((event, emit) async {
      _noMoreData = false;
      emit(UserClearState());
      emit(UserListLoadingState());
      await _useCase.getUsers(_limit, clear: true).then((value) {
        if (value.length < _limit) {
          _noMoreData = true;
        }
        emit(UserDataFetchedState(value));
      }).catchError((onError) {
        emit(UserListErrorState(onError));
      });
    });
    on<LoadMoreEvent>((event, emit) async {
      if (_noMoreData) {
        emit(UserIdleState());
        return;
      }

      emit(UserPaginationLoadingState());
      await _useCase
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
    on<AddUpdateEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        await _useCase.addUpdateUser(event.user).then((value) {
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
    on<DeleteUserEvent>((event, emit) async {
      emit(UserListLoadingState());
      try {
        await _useCase.deleteUser(event.user).then((value) {
          emit(UserDeleteState(value));
        });
      } catch (e) {
        emit(UserListErrorState(e));
      }
    });
  }
}
