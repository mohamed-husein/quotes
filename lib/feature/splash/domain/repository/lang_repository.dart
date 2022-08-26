import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';

abstract class BaseLangRepository
{
  Future<Either<Failure,bool>> changeLang({required String langCode});
  Future<Either<Failure,String>> getSaved();
}