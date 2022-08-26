import 'dart:convert';
import 'package:quotes/core/error/exception.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/feature/random_quotes/data/model/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseLocalDataSource {
  Future<QuoteModel> getLastRandomQuotes();
  Future<bool> cacheQuote(QuoteModel quote);
}

class LocalDataSource implements BaseLocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSource({required this.sharedPreferences});

  @override
  Future<QuoteModel> getLastRandomQuotes()  {
    final jsonString = sharedPreferences.getString(AppStrings.randomQuoteLocalKey);
    if (jsonString != null) {
      final cacheRandomQuote =
      Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cacheRandomQuote;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheQuote(QuoteModel quote)  async{
    return await sharedPreferences.setString(
        AppStrings.randomQuoteLocalKey, json.encode(quote));
  }
}
