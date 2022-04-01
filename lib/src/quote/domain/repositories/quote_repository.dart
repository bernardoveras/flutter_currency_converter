import '../entities/quote_entity.dart';
import '../enums/currency_enum.dart';

abstract class IQuoteRepository {
  Future<QuoteEntity> getCurrencyQuote(Currency currency, Currency currencyIn);
}