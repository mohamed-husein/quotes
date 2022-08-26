import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exception.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/feature/random_quotes/data/datasource/local_datasource.dart';
import 'package:quotes/feature/random_quotes/data/datasource/remote_datasource.dart';
import 'package:quotes/feature/random_quotes/domain/entities/quote_entities.dart';
import 'package:quotes/feature/random_quotes/domain/repository/base_quote_repository.dart';

class QuoteRepository extends BaseQuoteRepository {
  final BaseRemoteDataSource baseRemoteDataSource;
  final BaseLocalDataSource baseLocalDataSource;
  final NetworkInfo networkInfo;

  QuoteRepository(this.baseRemoteDataSource, this.baseLocalDataSource, this.networkInfo);

  @override
  Future<Either<Failure, QuoteEntities>> randomQuotes() async {
    if(await networkInfo.isConnected)
    {
      try {
      final remoteDataSource = await baseRemoteDataSource.getRandomQuotes();
       baseLocalDataSource.cacheQuote(remoteDataSource);
        return Right(remoteDataSource);
      } on ServerException {
        return  Left(
          ServerFailure(),
        );
      }
    }
    else{
      final localDataSource = await baseLocalDataSource.getLastRandomQuotes();
      try {
        return Right(localDataSource);
      } on CacheException {
        return  Left(
          CacheFailure(),
        );
      }
    }

  }
}
