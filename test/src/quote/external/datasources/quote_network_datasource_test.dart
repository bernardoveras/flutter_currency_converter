import 'dart:convert';

import 'package:currency_converter/src/core/constants.dart';
import 'package:currency_converter/src/core/http/external/dio/dio_client_adapter.dart';
import 'package:currency_converter/src/quote/domain/entities/quote_entity.dart';
import 'package:currency_converter/src/quote/domain/enums/currency_enum.dart';
import 'package:currency_converter/src/quote/external/datasources/quote_network_datasource.dart';
import 'package:currency_converter/src/quote/infra/adapters/map_to_quote.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../core/http/external/dio/dio_client_adapter_test.dart';

void main() {
  late final DioMock dio;
  late final DioClientAdapter adapter;
  late final QuoteNetworkDatasource datasource;

  const Currency currency = Currency.brl;
  const Currency currencyIn = Currency.usd;

  setUpAll(() {
    dio = DioMock();
    adapter = DioClientAdapter(dio);
    datasource = QuoteNetworkDatasource(adapter);
  });
  test('quote network datasource ...', () async {
    final String code = '${currency.name.toUpperCase()}${currencyIn.name.toUpperCase()}';
    var responsePayload = fixture('quote_success');
    var response = Response(
      requestOptions: RequestOptions(path: '$URL_CURRENCY_QUOTE/${currency.name}-${currencyIn.name}'),
      data: responsePayload,
      statusCode: 200,
    );

    when(() => dio.get(any(), options: any(named: 'options'))).thenAnswer((_) async => response);

    var result = await datasource.getCurrencyQuote(currency, currencyIn);

    var quote = MapToQuote.fromMap(result);

    expect(result, isA<Map>());
    expect(result, jsonDecode(responsePayload)[code]);
    expect(quote, isA<QuoteEntity>());
  });
}
