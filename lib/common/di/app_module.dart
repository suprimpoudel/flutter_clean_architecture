import 'package:flutter_clean_architecture/common/utilities/helpers/db_helper.dart';
import 'package:flutter_clean_architecture/common/utilities/services/base_service.dart';
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

  var baseService = BaseService();

  locator.registerLazySingleton<DBHelper>(
    () => dbHelper,
  );
  locator.registerLazySingleton<RandomDogRepository>(
    () => RandomDogRepositoryImpl(
      RandomDogDataSource(
        baseService,
      ),
    ),
  );
  locator.registerFactory(() => RandomDogUseCase(locator()));
  locator.registerFactory(() => RandomDogCubit(locator()));

  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      UserDataSource(
        dbHelper,
      ),
    ),
  );
  locator.registerFactory(() => UserUseCase(locator()));
  locator.registerFactory(() => UserBloc(locator()));
}
