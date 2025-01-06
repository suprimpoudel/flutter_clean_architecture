import 'package:flutter_clean_architecture/common/utilities/helpers/api_helper.dart';
import 'package:flutter_clean_architecture/common/utilities/helpers/db_helper.dart';
import 'package:flutter_clean_architecture/feature/random_dog/data/data_sources/random_dog_data_source.dart';
import 'package:flutter_clean_architecture/feature/random_dog/data/repositories/random_dog_repository.dart';
import 'package:flutter_clean_architecture/feature/random_dog/domain/repositories/random_dog_repository.dart';
import 'package:flutter_clean_architecture/feature/random_dog/domain/use_cases/random_dog_use_case.dart';
import 'package:flutter_clean_architecture/feature/random_dog/presentation/manager/random_dog_cubit.dart';
import 'package:flutter_clean_architecture/feature/user/data/data_sources/user_data_source.dart';
import 'package:flutter_clean_architecture/feature/user/data/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/feature/user/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/feature/user/domain/use_cases/user_use_case.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_bloc.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> appModuleSetup() async {
  var dbHelper = DBHelper();
  await dbHelper.init();

  var apiHelper = ApiHelper();

  locator.registerLazySingleton<DBHelper>(
    () => dbHelper,
  );

  //Random Dog
  var randomDogRepo = RandomDogRepositoryImpl(
    RandomDogDataSource(
      apiHelper,
    ),
  );
  var randomDogUseCase = RandomDogUseCase(randomDogRepo);

  locator.registerLazySingleton<RandomDogRepository>(() => randomDogRepo);
  locator.registerFactory<RandomDogUseCase>(() => randomDogUseCase);
  locator
      .registerFactory<RandomDogCubit>(() => RandomDogCubit(randomDogUseCase));

  //User
  var userRepo = UserRepositoryImpl(
    UserDataSource(
      dbHelper,
    ),
  );
  var userUseCase = UserUseCase(userRepo);

  locator.registerLazySingleton<UserRepository>(() => userRepo);
  locator.registerFactory<UserUseCase>(() => userUseCase);
  locator.registerFactory<UserBloc>(() => UserBloc(userUseCase));
}
