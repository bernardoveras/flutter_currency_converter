import 'package:currency_converter/src/quote/domain/entities/quote_entity.dart';
import 'package:currency_converter/src/quote/domain/enums/currency_enum.dart';

import '../../../core/helpers/timestamp_converter.dart';

class MapToQuote {
  const MapToQuote._();

  static QuoteEntity fromMap(Map map) {
    return QuoteEntity(
      currency: Currency.values.firstWhere((x) => x.name.toLowerCase() == map['code'].toLowerCase()),
      currencyIn: Currency.values.firstWhere((x) => x.name.toLowerCase() == map['codein'].toLowerCase()),
      quote: double.parse(map['high']),
      lastUpdate: TimestampHelper.toDateTime(int.parse(map['timestamp'])),
    );
  }
}
