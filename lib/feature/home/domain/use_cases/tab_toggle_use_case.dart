import 'package:equatable/equatable.dart';

abstract class TabToggleUseCase extends Equatable {
  const TabToggleUseCase();

  @override
  List<Object?> get props => [];
}

class APITabToggleCase extends TabToggleUseCase {}

class DatabaseTabToggleCase extends TabToggleUseCase {}
