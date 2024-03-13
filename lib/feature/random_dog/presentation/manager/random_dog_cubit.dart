import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/common/di/app_module.dart';
import 'package:flutter_clean_architecture/feature/random_dog/domain/entities/random_dog_state.dart';
import 'package:flutter_clean_architecture/feature/random_dog/domain/repositories/random_dog_repository.dart';

class RandomDogCubit extends Cubit<RandomDogState> {
  late RandomDogRepository _repository;

  RandomDogCubit() : super(RandomDogIdleState()) {
    _repository = locator.get<RandomDogRepository>();
  }

  void getRandomDogImage() async {
    if (state is RandomDogLoadingState) {
      return;
    }
    emit(RandomDogLoadingState());
    await _repository.getRandomDogImage().then((value) {
      emit(
        RandomDogFetchedState(
          value,
        ),
      );
    }).catchError((onError) {
      emit(
        RandomDogErrorState(
          onError,
        ),
      );
    });
  }
}
