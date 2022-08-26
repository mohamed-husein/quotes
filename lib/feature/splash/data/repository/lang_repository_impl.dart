import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exception.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/feature/splash/data/datasource/lang_locale_datasource.dart';
import 'package:quotes/feature/splash/domain/repository/lang_repository.dart';

class LangRepositoryImpl extends BaseLangRepository {

  final LangLocaleDatasource langLocaleDatasource;

  LangRepositoryImpl({required this.langLocaleDatasource});

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    final langIsChanged = await langLocaleDatasource.changeLang(
        langCode: langCode);
    try {
      return Right(langIsChanged);
    }
    on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSaved() async {
    final langCode = await langLocaleDatasource.getSaved();
    try {
      return Right(langCode);
    }
    on CacheException {
      return Left(CacheFailure());
    }
  }
}