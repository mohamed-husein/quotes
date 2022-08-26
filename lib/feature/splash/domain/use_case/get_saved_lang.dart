import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/use_case/base_use_case.dart';
import 'package:quotes/feature/splash/domain/repository/lang_repository.dart';

class GetSavedLangUseCase extends BaseUseCase<String, NoParameters> {
  final BaseLangRepository baseLangRepository;

  GetSavedLangUseCase({required this.baseLangRepository});

  @override
  Future<Either<Failure, String>> call(NoParameters params) async {
    return baseLangRepository.getSaved();
  }
}
