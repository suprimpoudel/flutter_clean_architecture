import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/feature/home/domain/use_cases/tab_toggle_use_case.dart';

class TabBloc extends Bloc<TabToggleUseCase, int> {
  TabBloc() : super(0) {
    on<APITabToggleCase>((event, emit) {
      emit(0);
    });
    on<DatabaseTabToggleCase>((event, emit) async {
      emit(1);
    });
  }
}
