part of 'random_quotes_cubit.dart';

abstract class RandomQuotesState extends Equatable {
  @override
  List<Object> get props => [];
}

class RandomQuotesInitial extends RandomQuotesState {}

class RandomQuotesIsLoading extends RandomQuotesState {}


class RandomQuotesLoaded extends RandomQuotesState {
  final QuoteEntities quote;

  RandomQuotesLoaded({required this.quote});

  @override
  List<Object> get props => [quote];
}

class RandomQuotesFailed extends RandomQuotesState {
  final String message;

  RandomQuotesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
