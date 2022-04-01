import 'package:test/test.dart';

import 'package:currency_converter/src/quote/domain/entities/quote_entity.dart';
import 'package:currency_converter/src/quote/infra/adapters/map_to_quote.dart';
import '../mocks/currency_quote_datasource_result.dart';

void main() {
  test('Should return a QuoteEntity', () {
    final quote = MapToQuote.fromMap(currencyQuoteDatasourceResult);

    expect(quote, isA<QuoteEntity>());
  });
}
