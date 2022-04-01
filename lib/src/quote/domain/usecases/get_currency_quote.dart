import 'package:currency_converter/src/quote/domain/repositories/quote_repository.dart';

import '../entities/quote_entity.dart';
import '../enums/currency_enum.dart';

abstract class IGetCurrencyQuote {
  Future<QuoteEntity> call(Currency currency, Currency currencyIn);
}

class GetCurrencyQuote implements IGetCurrencyQuote {
  GetCurrencyQuote(this._repository);

  final IQuoteRepository _repository;

  @override
  Future<QuoteEntity> call(Currency currency, Currency currencyIn) {
    return _repository.getCurrencyQuote(currency, currencyIn);
  }
}
