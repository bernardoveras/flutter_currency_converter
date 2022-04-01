import 'dart:convert';

import 'package:dio/dio.dart';

import '../../infra/http_response.dart';

class DioResponseAdapter {
  const DioResponseAdapter._();

  static HttpResponse<T> toHttpAdapter<T>(Response response) {
    return HttpResponse<T>(
      statusCode: response.statusCode,
      data: jsonDecode(response.data),
      headers: response.headers.map,
      statusMessage: response.statusMessage,
    );
  }
}
