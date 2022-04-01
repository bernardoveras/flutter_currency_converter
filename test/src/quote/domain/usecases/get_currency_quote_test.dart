import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:currency_converter/src/quote/domain/entities/quote_entity.dart';
import 'package:currency_converter/src/quote/domain/enums/currency_enum.dart';
import 'package:currency_converter/src/quote/domain/repositories/quote_repository.dart';
import 'package:currency_converter/src/quote/domain/usecases/get_currency_quote.dart';

class QuoteRepositoryMock extends Mock implements IQuoteRepository {}

class QuoteEntityMock extends Mock implements QuoteEntity {}

void main() {
  test('Should return a list of QuoteEntity', () async {
    final repository = QuoteRepositoryMock();
    final usecase = GetCurrencyQuote(repository);
    final entity = QuoteEntityMock();

    when(() => repository.getCurrencyQuote(Currency.brl, Currency.usd)).thenAnswer((_) => Future.value(entity));

    final result = await usecase.call(Currency.brl, Currency.usd);

    expect(result, entity);
  });
}
