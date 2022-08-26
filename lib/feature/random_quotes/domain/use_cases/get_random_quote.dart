import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/use_case/base_use_case.dart';
import 'package:quotes/feature/random_quotes/domain/entities/quote_entities.dart';
import 'package:quotes/feature/random_quotes/domain/repository/base_quote_repository.dart';

class GetRandomQuote extends BaseUseCase<QuoteEntities,NoParams> {
  final BaseQuoteRepository quoteRepository;

  GetRandomQuote({required this.quoteRepository});

  @override
  Future<Either<Failure, QuoteEntities>> call(NoParams params) async {
    return await quoteRepository.randomQuotes();
  }
}
