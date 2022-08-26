import 'package:quotes/core/error/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:quotes/core/use_case/base_use_case.dart';

import 'package:quotes/feature/splash/domain/repository/lang_repository.dart';

class GetSavedLangUseCase implements BaseUseCase<String, NoParams> {
  final LangRepository langRepository;

  GetSavedLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await langRepository.getSavedLang();
}
