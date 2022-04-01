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
    final String code = '${currency.name.toUpperCase()}${currencyIn.name.toUpperCase()}';

    var result = await _datasource.getCurrencyQuote(currency, currencyIn);

    if (!result.containsKey(code)) {
      throw Exception('Ocorreu um erro ao buscar a cotação');
    }

    return _deserialize(result[code]);
  }

  QuoteEntity _deserialize(Map map) => MapToQuote.fromMap(map);
}
