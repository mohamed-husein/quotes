import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/use_case/base_use_case.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/feature/random_quotes/domain/entities/quote_entities.dart';
import 'package:quotes/feature/random_quotes/domain/use_cases/get_random_quote.dart';

part 'random_quotes_state.dart';

class RandomQuotesCubit extends Cubit<RandomQuotesState> {
  final GetRandomQuote getRandomQuote;

  RandomQuotesCubit({required this.getRandomQuote})
      : super(RandomQuotesInitial());

  Future getRandomQuotes() async {
    emit(RandomQuotesIsLoading());
    final response = await getRandomQuote(const NoParameters());

    response.fold(
      (l) => emit(RandomQuotesFailed(message: _mapFailureToString(l))),
      (r) => emit(RandomQuotesLoaded(quote: r)),
    );
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unExpectedFailure;
    }
  }
}
