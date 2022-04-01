import '../enums/currency_enum.dart';

class QuoteEntity {
  final Currency currency;
  final Currency currencyIn;
  final double quote;
  final DateTime lastUpdate;

  QuoteEntity({
    required this.currency,
    required this.currencyIn,
    required this.quote,
    required this.lastUpdate,
  });
}
