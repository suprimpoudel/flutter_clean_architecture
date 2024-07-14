import 'package:equatable/equatable.dart';

abstract class BaseMapper extends Equatable{
  const BaseMapper();

  Map<String, dynamic> toMap();
}