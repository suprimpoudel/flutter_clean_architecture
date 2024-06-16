import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/feature/random_dog/domain/use_cases/random_dog_use_case.dart';
import 'package:flutter_clean_architecture/feature/random_dog/presentation/manager/random_dog_state.dart';

class RandomDogCubit extends Cubit<RandomDogState> {
  final RandomDogUseCase _useCase;

  RandomDogCubit(this._useCase) : super(RandomDogIdleState());

  void getRandomDogImage() async {
    if (state is RandomDogLoadingState) {
      return;
    }
    emit(RandomDogLoadingState());
    await _useCase.getRandomDogImage.then((value) {
      emit(
        RandomDogFetchedState(value),
      );
    }).catchError((onError) {
      emit(
        RandomDogErrorState(onError),
      );
    });
  }
}
