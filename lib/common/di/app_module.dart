import 'package:flutter_clean_architecture/common/utilities/helpers/db_helper.dart';
import 'package:flutter_clean_architecture/common/utilities/services/base_service.dart';
import 'package:flutter_clean_architecture/feature/random_dog/data/data_sources/random_dog_data_source.dart';
import 'package:flutter_clean_architecture/feature/random_dog/data/repositories/random_dog_repository.dart';
import 'package:flutter_clean_architecture/feature/random_dog/domain/repositories/random_dog_repository.dart';
import 'package:flutter_clean_architecture/feature/user/data/data_sources/user_data_source.dart';
import 'package:flutter_clean_architecture/feature/user/data/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/feature/user/domain/repositories/user_repository.dart';
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
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      UserDataSource(
        dbHelper,
      ),
    ),
  );
}
