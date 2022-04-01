import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:dio/dio.dart';

import 'package:currency_converter/src/core/http/external/dio/dio_client_adapter.dart';
import 'package:currency_converter/src/core/http/infra/http_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final url = faker.internet.httpUrl();
  final headers = {'content-type': 'application/json; charset=utf-8', 'X-Serial': 2022};

  late final DioMock dio;
  late final DioClientAdapter client;

  setUpAll(() {
    dio = DioMock();
    client = DioClientAdapter(dio);
  });

  group('GET', () {
    test('Should succeed if the request is Ok', () async {
      var responsePayload = '{"status": "ok"}';
      var response = Response(
        requestOptions: RequestOptions(path: url, headers: headers),
        data: responsePayload,
        statusCode: 200,
      );

      when(() => dio.get(any(), options: any(named: 'options'))).thenAnswer((_) async => response);

      final result = await client.get(url, headers: headers);

      expect(result, isA<HttpResponse>());
      expect(result.data, {"status": "ok"});
      expect(result.statusCode, 200);
    });

    test('Should succeed if the request is Ok with no data', () async {
      var response = Response(
        requestOptions: RequestOptions(path: url, headers: headers),
        statusCode: 200,
      );

      when(() => dio.get(any(), options: any(named: 'options'))).thenAnswer((_) async => response);

      final result = await client.get(url, headers: headers);

      expect(result, isA<HttpResponse>());
      expect(result.data, null);
      expect(result.statusCode, 200);
    });
  });
}
