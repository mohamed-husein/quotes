import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quotes/core/error/failure.dart';

abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParameters extends Equatable {
  const NoParameters();

  @override
  List<Object?> get props => throw UnimplementedError();
}
