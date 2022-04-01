import 'package:currency_converter/src/quote/domain/enums/currency_enum.dart';
import 'package:currency_converter/src/quote/infra/datasources/quote_datasource.dart';

class QuoteNetworkDatasource implements IQuoteDatasource {
  @override
  Future<Map> getCurrencyQuote(Currency currency, Currency currencyIn) {
    // TODO: implement getCurrencyQuote
    throw UnimplementedError();
  }
}
