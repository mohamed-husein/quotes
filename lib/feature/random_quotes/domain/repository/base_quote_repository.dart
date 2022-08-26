import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/feature/random_quotes/domain/entities/quote_entities.dart';

abstract class BaseQuoteRepository
{
  Future<Either<Failure,QuoteEntities>> randomQuotes();
}