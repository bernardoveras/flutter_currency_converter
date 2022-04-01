import '../../domain/enums/currency_enum.dart';

abstract class IQuoteDatasource {
  Future<Map> getCurrencyQuote(Currency currency, Currency currencyIn);
}