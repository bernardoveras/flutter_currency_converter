import '../../domain/entities/quote_entity.dart';
import '../../domain/enums/currency_enum.dart';
import '../../domain/repositories/quote_repository.dart';
import '../adapters/map_to_quote.dart';
import '../datasources/quote_datasource.dart';

class QuoteRepository implements IQuoteRepository {
  const QuoteRepository(this._datasource);

  final IQuoteDatasource _datasource;

  @override
  Future<QuoteEntity> getCurrencyQuote(Currency currency, Currency currencyIn) async {
    var result = await _datasource.getCurrencyQuote(currency, currencyIn);

    return _deserialize(result);
  }

  QuoteEntity _deserialize(Map map) => MapToQuote.fromMap(map);
}
