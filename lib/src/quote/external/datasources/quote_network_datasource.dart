import 'package:currency_converter/src/core/http/infra/http_client.dart';
import 'package:currency_converter/src/quote/domain/enums/currency_enum.dart';
import 'package:currency_converter/src/quote/infra/datasources/quote_datasource.dart';

import '../../../core/constants.dart';

class QuoteNetworkDatasource implements IQuoteDatasource {
  const QuoteNetworkDatasource(this.http);

  final IHttpClient http;

  @override
  Future<Map> getCurrencyQuote(Currency currency, Currency currencyIn) async {
    final String code = '${currency.name.toUpperCase()}${currencyIn.name.toUpperCase()}';

    var result = await http.get('$URL_CURRENCY_QUOTE/${currency.name}-${currencyIn.name}');
    return result.data[code];
  }
}
