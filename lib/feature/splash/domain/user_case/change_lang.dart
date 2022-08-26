
import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/use_case/base_use_case.dart';
import 'package:quotes/feature/splash/domain/repository/lang_repository.dart';


class ChangeLangUseCase implements BaseUseCase<bool, String> {
  final LangRepository langRepository;

  ChangeLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await langRepository.changeLang(langCode: langCode);
}
