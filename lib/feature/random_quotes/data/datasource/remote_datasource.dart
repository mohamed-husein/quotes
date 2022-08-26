import 'dart:convert';

import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/end_point.dart';
import 'package:quotes/core/error/exception.dart';
import 'package:quotes/feature/random_quotes/data/model/quote_model.dart';

abstract class BaseRemoteDataSource {
  Future<QuoteModel> getRandomQuotes();
}

class RemoteDataSource extends BaseRemoteDataSource {
  final ApiConsumer apiConsumer;

  RemoteDataSource({required this.apiConsumer});
  @override
  Future<QuoteModel> getRandomQuotes() async {
    final response = await apiConsumer.get(path: EndPoints.randomQuoteApi);
    if (response.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(response.data));
    } else {
      throw const ServerException();
    }
  }
}
