import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/use_case/base_use_case.dart';
import 'package:quotes/feature/splash/domain/repository/lang_repository.dart';

class ChangeLocaleUseCase extends BaseUseCase<bool, String>
{
  final BaseLangRepository baseLangRepository;

  ChangeLocaleUseCase({required this.baseLangRepository});
  @override
  Future<Either<Failure, bool>> call(String params)async {

    return await baseLangRepository.changeLang(langCode: params);
  }

}