import 'package:currency_converter/src/quote/domain/repositories/quote_repository.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/quote_mocks.dart';
import 'package:currency_converter/src/quote/domain/enums/currency_enum.dart';
import 'package:currency_converter/src/quote/domain/usecases/get_currency_quote.dart';

void main() {
  late IQuoteRepository repository;
  late IGetCurrencyQuote usecase;

  setUpAll(() {
    repository = QuoteRepositoryMock();
    usecase = GetCurrencyQuote(repository);
  });

  test('Should return a list of QuoteEntity', () async {
    final entity = QuoteEntityMock();

    when(() => repository.getCurrencyQuote(Currency.brl, Currency.usd)).thenAnswer((_) => Future.value(entity));

    final result = await usecase.call(Currency.brl, Currency.usd);

    expect(result, entity);
  });
}
