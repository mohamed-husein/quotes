import 'package:quotes/feature/random_quotes/domain/entities/quote_entities.dart';

class QuoteModel extends QuoteEntities {
  const QuoteModel({
    required super.author,
    required super.id,
    required super.quote,
    required super.permalink,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      author: json['author'],
      id: json['id'],
      quote: json['quote'],
      permalink: json['permalink'],
    );
  }

  Map<String, dynamic> toJson() => {
    "author": author,
    "id": id,
    "quote": quote,
    "permalink": permalink,
  };
}
