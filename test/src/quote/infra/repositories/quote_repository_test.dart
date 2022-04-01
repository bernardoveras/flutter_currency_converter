import 'package:currency_converter/src/quote/domain/entities/quote_entity.dart';
import 'package:currency_converter/src/quote/domain/enums/currency_enum.dart';
import 'package:currency_converter/src/quote/infra/repositories/quote_repository.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:currency_converter/src/quote/infra/datasources/quote_datasource.dart';

import '../mocks/currency_quote_datasource_result.dart';

class QuoteDatasourceMock extends Mock implements IQuoteDatasource {}

void main() {
  late IQuoteDatasource datasource;
  late QuoteRepository repository;

  setUpAll(() {
    datasource = QuoteDatasourceMock();
    repository = QuoteRepository(datasource);
  });

  test('Should return a QuoteEntity', () async {
    when(() => datasource.getCurrencyQuote(Currency.brl, Currency.usd)).thenAnswer((_) => Future.value(currencyQuoteDatasourceResult));

    final result = await repository.getCurrencyQuote(Currency.brl, Currency.usd);

    expect(result, isA<QuoteEntity>());
    expect(result.currency, Currency.brl);
    expect(result.currencyIn, Currency.usd);
    expect(result.quote, 0.211);
  });
}
